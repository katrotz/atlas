"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const manifest_json_1 = require("./../../../manifest.json");
var HealthStatus;
(function (HealthStatus) {
    HealthStatus["PASS"] = "pass";
    HealthStatus["WARN"] = "warn";
    HealthStatus["FAIL"] = "fail";
})(HealthStatus = exports.HealthStatus || (exports.HealthStatus = {}));
exports.getServiceName = () => manifest_json_1.name;
exports.getServiceVersion = () => manifest_json_1.version;
exports.getServiceDescription = () => manifest_json_1.description;
exports.getServiceStatus = () => HealthStatus.PASS;
exports.buildHealthResponse = () => __awaiter(this, void 0, void 0, function* () {
    return Promise.resolve({
        serviceID: exports.getServiceName(),
        description: exports.getServiceDescription(),
        version: exports.getServiceVersion(),
        status: exports.getServiceStatus(),
        notes: []
    });
});
//# sourceMappingURL=ServiceStatusProvider.js.map