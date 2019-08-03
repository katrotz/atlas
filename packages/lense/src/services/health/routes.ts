import { Request, Response } from 'express';
import { getHealthStatus } from './HealthController';
import { genericCheck } from '../../middleware/checks';

export default [
  {
    path: '/api/v1/health',
    method: 'get',
    handler: [
      genericCheck,
      async (req: Request, res: Response) => {
        const result = await getHealthStatus();

        res.status(200).send(result);
      }
    ]
  }
];
