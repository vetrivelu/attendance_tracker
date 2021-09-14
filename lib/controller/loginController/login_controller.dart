
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}