import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { SkiResortDocument } from '../documents/ski-resort.doc';
import { Model } from 'mongoose';
import { skiResortCollectionName, skiResortDbName } from '../constants';

@Injectable()
export class SkiResortRepo {
  constructor(@InjectModel(skiResortCollectionName, skiResortDbName) private catModel: Model<SkiResortDocument>) {}
}
