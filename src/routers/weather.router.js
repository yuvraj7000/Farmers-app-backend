import { Router } from "express";
import { todaysWeather, getWeatherData } from "../controllers/weather.controller.js";

const weather_router = Router();
weather_router.route("/current").get(todaysWeather);
weather_router.route("/forcast").get(getWeatherData);

export default weather_router;