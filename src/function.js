import fastify from "fastify";
import awsLambdaFastify from "aws-lambda-fastify";

const app = fastify();
app.route({
  method: "GET",
  url: "/api/",
  handler: async (request, reply) => reply.send({ data: "dummy GET" }),
});

app.route({
  method: "POST",
  url: "/api/",
  handler: async (request, reply) => reply.send({ data: "dummy POST" }),
});

const proxy = awsLambdaFastify(app);

// exports.handler = async function (event, context) {
// https://www.netlify.com/blog/2021/04/02/modern-faster-netlify-functions/
export async function handler(event, context) {
  let a = await proxy(event, context);
  console.log(a);
  return a;
}
