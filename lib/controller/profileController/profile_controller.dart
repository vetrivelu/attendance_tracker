

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracer/constants/controller.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  TextEditingController idController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController icNumController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();


}