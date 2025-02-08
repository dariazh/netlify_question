import fastify from "fastify";
import awsLambdaFastify from "aws-lambda-fastify";

const app = fastify();

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
