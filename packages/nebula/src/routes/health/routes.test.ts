import express, { Router } from 'express';
import request from 'supertest';
import { applyMiddleware, applyRoutes } from '../../utils';
import middleware from '../../middleware';
import errorHandlers from '../../middleware/errorHandlers';
import routes from '../../routes/health/routes';
import { HealthStatus } from './providers/ServiceStatusProvider';

jest.mock('request-promise');

describe('health service routes', () => {
  let router: Router;

  beforeEach(() => {
    router = express();
    applyMiddleware(middleware, router);
    applyRoutes(routes, router);
    applyMiddleware(errorHandlers, router);
  });

  describe('health status', () => {
    test('status code', async () => {
      const response = await request(router).get('/api/v1/health');

      expect(response.status).toEqual(200);
    });

    test('response status field', async () => {
      const response = await request(router).get('/api/v1/health');
      const responseJson = JSON.parse(response.text);

      expect(responseJson).toHaveProperty('status', HealthStatus.PASS);
    });
  });
});
