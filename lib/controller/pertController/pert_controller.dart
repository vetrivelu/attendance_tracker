import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PertController extends GetxController {
  static PertController instance = Get.find();
  RxBool yesButton = false.obs;
  RxBool noButton = false.obs;
}