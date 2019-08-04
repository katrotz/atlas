import { buildHealthResponse, HealthResponse } from './providers/ServiceStatusProvider';

export const getHealthStatus = async (): Promise<HealthResponse> => {
  return await buildHealthResponse();
};
