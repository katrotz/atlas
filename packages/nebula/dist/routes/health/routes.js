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
const HealthController_1 = require("./HealthController");
const checks_1 = require("../../middleware/checks");
exports.default = [
    {
        path: '/api/v1/health',
        method: 'get',
        handler: [
            checks_1.genericCheck,
            (req, res) => __awaiter(this, void 0, void 0, function* () {
                const result = yield HealthController_1.getHealthStatus();
                res.status(200).set('Content-Type', 'application/health+json').send(result);
            })
        ]
    }
];
//# sourceMappingURL=routes.js.map