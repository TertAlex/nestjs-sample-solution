import { HydratedDocument } from 'mongoose';

export type SkiResortDocument = HydratedDocument<SkiResortDoc>;

export class SkiResortDoc {
  title: string;
  country: string;
  slopes: {
    easy: number;
    intermediate: number;
    difficult: number;
  };
}
