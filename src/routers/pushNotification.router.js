import { addFcmToken, deleteFcmToken, getAllFcmTokens, sendPushNotification } from "../controllers/pushNotification.controller.js";
import { Router } from "express";


const pushNotification_router = Router();

pushNotification_router.route("/add").post(addFcmToken);
pushNotification_router.route("/delete").post(deleteFcmToken);
pushNotification_router.route("/getall").get(getAllFcmTokens);
pushNotification_router.route("/sendall").post(sendPushNotification);

export default pushNotification_router;