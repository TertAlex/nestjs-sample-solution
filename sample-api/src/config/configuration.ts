export default () => ({
  port: parseInt(process.env.PORT, 10) || 3000,
  mongoUri: `mongodb://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@${process.env.MONGO_HOST}:${process.env.MONGO_PORT}`,
});
