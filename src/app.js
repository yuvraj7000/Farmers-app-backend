import express, { urlencoded } from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import diagnose_router from './routers/diagnose.router.js';
import weather_router from './routers/weather.router.js';
import schemes_router from './routers/schemes.router.js';
import crop_router from './routers/crop.router.js';
import pushNotification_router from './routers/pushNotification.router.js';
import newsRouter from './routers/news.router.js';

const app = express();
app.use(cors('*'));
app.use(express.json());
app.use(express.urlencoded({extended: true, limit: '100kb'}));
app.use(express.static('public'));
app.use(bodyParser.json());


export default app;

app.use("/api/v1/diagnose", diagnose_router);
app.use("/api/v1/weather", weather_router);
app.use("/api/v1/schemes", schemes_router);
app.use("/api/v1/crop", crop_router);
app.use("/api/v1/news", newsRouter);
app.use("/api/v1/pushNotification", pushNotification_router);
