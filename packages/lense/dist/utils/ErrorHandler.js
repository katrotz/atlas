"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const httpErrors_1 = require("./httpErrors");
const errors_1 = require("request-promise/errors");
const isTestEnvironment = ('test' === process.env.NODE_ENV);
const errorToResponseBody = (errorMessage, responseBody = { errors: [] }) => {
    responseBody.errors.push(errorMessage);
    return responseBody;
};
exports.notFoundError = () => {
    throw new httpErrors_1.HTTP404Error('Method not found.');
};
exports.clientError = (err, res, next) => {
    if (err instanceof httpErrors_1.HTTPClientError) {
        !isTestEnvironment && console.warn(err);
        res.status(err.statusCode).json(errorToResponseBody(err.message));
    }
    else {
        next(err);
    }
};
exports.remoteServerError = (err, res, next) => {
    if (err instanceof errors_1.StatusCodeError) {
        !isTestEnvironment && console.warn(err);
        try {
            const errorResponse = JSON.parse(err.error);
            res.status(err.statusCode).json(errorToResponseBody(errorResponse.error));
        }
        catch (parseError) {
            return next(parseError);
        }
    }
    else {
        next(err);
    }
};
exports.serverError = (err, res, next) => {
    !isTestEnvironment && console.error(err);
    if (process.env.NODE_ENV === 'production') {
        res.status(500).json(errorToResponseBody('Internal Server Error'));
    }
    else {
        res.status(500).json(errorToResponseBody(err.stack || err.message));
    }
};
//# sourceMappingURL=ErrorHandler.js.map