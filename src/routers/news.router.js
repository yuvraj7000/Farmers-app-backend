import { Router } from "express";
import { getAllNews, addNews, updateNews, deleteNews } from "../controllers/news.controller.js";

const newsRouter = Router();

newsRouter.route("/get").post(getAllNews);
newsRouter.route("/add").post(addNews);
newsRouter.route("/update").post(updateNews);
newsRouter.route("/delete").post(deleteNews);

export default newsRouter;
