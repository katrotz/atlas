import {
  handleCors,
  handleBodyRequestParsing,
  handleCompression
} from './common';
import { handleAPIDocs } from "./docs";

export default [handleCors, handleBodyRequestParsing, handleCompression, handleAPIDocs];
