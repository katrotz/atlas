import * as Provider from './ServiceStatusProvider';
import { HealthStatus } from './ServiceStatusProvider';

describe('ServiceStatusProvider', () => {
  test('provides the status field', async () => {
    await expect(Provider.buildHealthResponse()).resolves.toHaveProperty('status', HealthStatus.PASS);
  });
});
