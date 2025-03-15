import express, { urlencoded } from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import diagnose_router from './routers/diagnose.router.js';
import weather_router from './routers/weather.router.js';
import schemes_router from './routers/schemes.router.js';


const app = express();
app.use(cors('*'));
app.use(express.json({limit: '16kb'}));
app.use(express.urlencoded({extended: true, limit: '16kb'}));
app.use(express.static('public'));
app.use(bodyParser.json());


export default app;

app.use("/api/v1/diagnose", diagnose_router);
app.use("/api/v1/weather", weather_router);
app.use("/api/v1/schemes", schemes_router);
