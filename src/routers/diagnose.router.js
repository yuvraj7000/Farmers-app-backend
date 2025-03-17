import { plantDiagnose } from "../controllers/diagnose.controller.js";
import { upload } from "../middlewares/multer.middleware.js";
import { Router } from "express";

const diagnose_router = Router();

diagnose_router.route("/plant").post(upload.single('image'), plantDiagnose);


export default diagnose_router;