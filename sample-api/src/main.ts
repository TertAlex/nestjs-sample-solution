import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { Logger } from '@nestjs/common';
import { NestExpressApplication } from '@nestjs/platform-express';
import { ConfigService } from '@nestjs/config';

const logger = new Logger(bootstrap.name);

process.on('uncaughtException', (error: Error) => {
  logger.error(
    {
      message: 'Process crashed',
      data: error.message,
    },
    error.stack,
  );
  setTimeout(() => {
    process.exit();
  }, 1000);
});

async function bootstrap(): Promise<void> {
  logger.log('Running sample api app: start');

  const app = await NestFactory.create<NestExpressApplication>(AppModule, {
    rawBody: true,
    logger,
  });

  const configService: ConfigService = app.get(ConfigService);
  const port = configService.get<number>('port');

  await app.listen(port);
}

bootstrap()
  .then(() => {
    logger.log('Running sample api app: end');
  })
  .catch((error: Error) => {
    logger.error(
      {
        message: 'Running sample api app: error',
        data: error.message,
      },
      error,
    );
  });
