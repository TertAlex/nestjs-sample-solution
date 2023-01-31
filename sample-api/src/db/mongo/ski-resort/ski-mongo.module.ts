import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { SkiResortRepo } from './repositories/ski-resort.repo';
import { SkiResortSchema } from './schemas/ski-resort.schema';
import { skiResortCollectionName, skiResortDbName } from './constants';

@Module({
  imports: [
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (configService: ConfigService) => ({
        uri: `${configService.get<string>('mongoUri')}/${skiResortDbName}?authSource=admin`,
      }),
      inject: [ConfigService],
      connectionName: skiResortDbName,
    }),
    MongooseModule.forFeature([{ name: skiResortCollectionName, schema: SkiResortSchema }], skiResortDbName),
  ],
  providers: [SkiResortRepo],
})
export class SkiMongoModule {}
