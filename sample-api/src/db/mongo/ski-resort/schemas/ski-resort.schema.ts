import * as mongoose from 'mongoose';

export const SkiResortSchema = new mongoose.Schema({
  title: String,
  country: String,
  slopes: {
    easy: Number,
    intermediate: Number,
    difficult: Number,
  },
});
