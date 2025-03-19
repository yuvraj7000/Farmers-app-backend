import { addFcmToken, deleteFcmToken, getAllFcmTokens } from "../controllers/pushNotification.controller.js";
import { Router } from "express";


const pushNotification_router = Router();

pushNotification_router.route("/add").post(addFcmToken);
pushNotification_router.route("/delete").post(deleteFcmToken);
pushNotification_router.route("/getall").get(getAllFcmTokens);

export default pushNotification_router;