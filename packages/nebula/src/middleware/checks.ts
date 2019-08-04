import { Request, Response, NextFunction } from 'express';

export const genericCheck = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  next();
};
