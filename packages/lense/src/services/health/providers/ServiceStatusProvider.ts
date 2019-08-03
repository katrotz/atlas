import { name as appName, version as appVersion, description as appDescription }  from './../../../package.json';

export enum HealthStatus {
  PASS = 'pass',
  WARN = 'warn',
  FAIL = 'fail'
}

// Check the IETF recommended health response for more info {@link https://tools.ietf.org/id/draft-inadarei-api-health-check-01.html}
export type HealthResponse = {
  status: HealthStatus,
  serviceID?: string,
  description?: string,
  version?: string,
  notes?: string[],
  output?: string,
}

export const getServiceName = () => appName;

export const getServiceVersion = () => appVersion;

export const getServiceDescription = () => appDescription;

export const getServiceStatus = () => HealthStatus.PASS;

export const buildHealthResponse = async () : Promise<HealthResponse> => {
  return Promise.resolve({
    serviceID: getServiceName(),
    description: getServiceDescription(),
    version: getServiceVersion(),
    status: getServiceStatus(),
    notes: []
  })
};
