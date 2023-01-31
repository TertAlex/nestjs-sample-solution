import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import configuration from './config/configuration';
import { SkiMongoModule } from './db/mongo/ski-resort/ski-mongo.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [configuration],
      isGlobal: true,
    }),
    SkiMongoModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
