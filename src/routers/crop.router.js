import { addCrop, getCropDetails, deleteCrop, updateCropPara, deleteCropPara, updateCrop, addCropPara } from "../controllers/crop.controller.js";
import { Router } from "express";

const crop_router = Router();

crop_router.route("/add").post(addCrop);
crop_router.route("/get").post(getCropDetails);
crop_router.route("/delete").post(deleteCrop);
crop_router.route("/update").post(updateCrop);
crop_router.route("/delete_para").post(deleteCropPara);
crop_router.route("/update_para").post(updateCropPara);
crop_router.route("/add_para").post(addCropPara);


export default crop_router;