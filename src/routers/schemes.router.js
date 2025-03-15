import { Router } from "express";
import { getallSchemes, addScheme, getstateSchemes, upsertScheme, upsertTranslation, deleteScheme, getTranslationSchemes } from "../controllers/schemes.controller.js";

const schemes_router = Router();
schemes_router.route("/get").post(getallSchemes);
schemes_router.route("/state").get(getstateSchemes);
schemes_router.route("/add").post(addScheme);
schemes_router.route("/updateScheme").post(upsertScheme);
schemes_router.route("/updateTranslation").post(upsertTranslation);
schemes_router.route("/getTranslationSchemes").post(getTranslationSchemes);
schemes_router.route("/delete").post(deleteScheme);

export default schemes_router;