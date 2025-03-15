import { Router } from "express";
import { todaysWeather } from "../controllers/weather.controller.js";

const weather_router = Router();
weather_router.route("/current").get(todaysWeather);

export default weather_router;