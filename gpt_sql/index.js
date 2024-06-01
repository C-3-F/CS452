require("dotenv").config();
const readline = require("readline");
const fs = require("fs/promises");
const OpenAi = require("openai");
const mysql = require("mysql2/promise");
const { resolve } = require("path");

const openAiKey = process.env.OPENAI_API_KEY;
const SQL_CONNECTION_STRING = process.env.SQL_CONNECTION_STRING;

console.log("OpenAI API Key: " + openAiKey);
console.log("SQL Connection String: " + SQL_CONNECTION_STRING);
// OpenAI Setup
const openai = new OpenAi(openAiKey);

//SQL Setup
const getDatabaseConnection = async () => {
    const parsedUrl = new URL(SQL_CONNECTION_STRING);
    const connectionConfig = {
        host: parsedUrl.hostname,
        user: parsedUrl.username,
        password: parsedUrl.password,
        database: parsedUrl.pathname.replace("/", ""), // Remove leading slash
        port: parsedUrl.port || 3306, // Use default MySQL port if not specified
        multipleStatements: true,
    };
    const connection = await mysql.createConnection(connectionConfig);
    return connection;
};
const setupDatabase = async () => {
    const connection = await getDatabaseConnection();
    const setupScript = (await fs.readFile("db_setup.sql", "utf8")).toString();
    const seedScript = (await fs.readFile("db_seed.sql", "utf8")).toString();
    await connection.query(setupScript);
    await connection.query(seedScript);
};

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

const askUserQuestion = (query) => {
    return new Promise((resolve) => {
        rl.question(query, (answer) => {
            resolve(answer);
        });
    }).finally(() => {
        rl.close();
    });
}

const queryChatGPT = async (query) => {
    // console.log(`Querying GPT-3 with: ${query}`);
    const response = await openai.chat.completions.create({
        model: "gpt-4-turbo-preview",
        messages: [{ role: "user", content: query }],
    });

    return response.choices[0].message.content;
};

const extractSQL = (value) => {
    const gptStartMarker = "```sql";
    const gptStartMarker2 = "```mysql";
    const gptEndMarker = "```";
    let startIndex = 0;
    let endIndex = value.length;

    if (value.includes(gptStartMarker)) {
        startIndex = value.indexOf(gptStartMarker) +  gptStartMarker.length;
        value = value.substring(startIndex);
    } else if (value.includes(gptStartMarker2)) {
        startIndex = value.indexOf(gptStartMarker2) +  gptStartMarker2.length;
        value = value.substring(startIndex);
    }
    if (value.includes(gptEndMarker)) {
        endIndex = value.indexOf(gptEndMarker);
    }

    return value.substring(0, endIndex).trim();
};

const runQuery = async (query) => {
    const connection = await getDatabaseConnection();
    const [results, fields] = await connection.query(query);
    return results;
};

const generateFriendlyResponseQuery = async (question, queryRawResponse) => {
    const friendlyResponseQuery = `I asked a question "${question}" and the response was "${queryRawResponse}" Please, just give a concise response in a more friendly way? Please do not give any other suggests or chatter.`;
    const friendlyResponse = await queryChatGPT(friendlyResponseQuery);

    return friendlyResponse;
};

async function main() {
    await setupDatabase();
    const sqlSchema = (await fs.readFile("schema.sql", "utf8")).toString();
    const questions = [];

    // const question = await askUserQuestion("Type your data question: ");
    // questions.push(question);

    questions.push("Where are there Metallica concerts?");
    questions.push(
        "How many staff members will be working at a concert in the month of May 2024?"
    );
    questions.push("How many concerts are there in 2024?");
    questions.push(
        "What is the total number of tickets sold for all concerts in 2024?"
    );
    questions.push("Which artist generated the most all-time revenue?");
    questions.push(
        "What is the total revenue generated by all concerts in 2024?"
    );
    questions.push("What is the average number of songs played at a concert?");

    const basicQuestion =
        "Give me a MySQL select statement that answers the question about data following the schema. Only respond with MySQL syntax. If there is an error do not expalin it!\n";
    const domainQuestion1 = "Where are there Harry Styles concerts?\n";
    const domainAnswer1 =
        "SELECT venue.name, venue.city FROM Venue\nINNER JOIN Concert ON venue.id = concert.venue_id\nINNER JOIN Artist ON concert.artist_id = artist.id\nWHERE artist.name = 'Harry Styles';\n";
    const domainQuestion2 =
        "How many staff members will be working at a concert on 2024-12-25?\n";
    const domainAnswer2 =
        "SELECT COUNT(*) FROM Staff\nINNER JOIN Concert ON staff.concert_id = concert.id\nWHERE concert.date = '2024-12-25';\n";

    const strategies = {
        "zero-shot": basicQuestion + sqlSchema,
        "single-domain":
            sqlSchema +
            "\n" +
            domainQuestion1 +
            domainAnswer1 +
            "\n" +
            domainQuestion2 +
            domainAnswer2 +
            "\n" +
            basicQuestion,
    };

    let results = [];

    for (const [strategy, query] of Object.entries(strategies)) {
        console.log(`\n\nRunning strategy: ${strategy}`);
        const responses = {
            strategy: strategy,
            promptPrefix: strategies[strategy],
        };
        let questionResults = [];
        for (question in questions) {
            const response = await queryChatGPT(
                query + questions[question] + sqlSchema
            );
            // console.log(`GPT Response 1: ${response}`);
            const sqlQuery = extractSQL(response);
            // console.log(`SQL Query: ${sqlQuery}`);
            if (sqlQuery) {
                try {
                    const result = await runQuery(sqlQuery);
                    const resultString = JSON.stringify(result, null, 2);

                    const friendlyResponse =
                        await generateFriendlyResponseQuery(
                            question,
                            resultString
                        );
                    console.log(friendlyResponse);

                    questionResults.push({
                        strategy: strategy,
                        question: questions[question],
                        rawSQL: sqlQuery,
                        sqlResult: resultString,
                        friendlyResponse: friendlyResponse,
                    });
                } catch (e) {
                    questionResults.push({
                        strategy: strategy,
                        question: questions[question],
                        rawSQL: sqlQuery,
                        sqlResult: e.message,
                        friendlyResponse: "Error: Could not run query.",
                    });
                    // console.error(e);
                    continue;
                }
            }
        }
        responses["questions"] = questionResults;
        results.push(responses);
    }

    await fs.writeFile(
        "results.json",
        JSON.stringify(results, null, 2),
        (err) => {
            if (err) {
                console.error(err);
                return;
            }
        }
    );
    return;
}

main()
    .then(() => {
        console.log("Done!");
    })
    .catch((e) => {
        console.error(e);
    })
    .finally(() => {
        rl.close();
        resolve();
    });
