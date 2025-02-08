import fastify from "fastify";
import awsLambdaFastify from "aws-lambda-fastify";
import {registerRoutes} from "../../src/routes/index.js";
const app = fastify();

async function setupRoutes() {
    await registerRoutes(app); // Регистрация маршрутов
}

setupRoutes().then(() => {
    console.log("Routes registered");
}).catch(err => {
    console.error("Error registering routes:", err);
});

// Роут на корневой путь
app.get("/", async (request, reply) => {
    return reply.send({ status: "ok" });
});
app.get("/health", async (request, reply) => {
    return reply.send({ status: "ok - health" });
});

const proxy = awsLambdaFastify(app);

export async function handler(event, context) {
    return proxy(event, context);
}
