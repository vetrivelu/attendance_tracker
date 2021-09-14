import 'package:get/get.dart';
import 'package:tracer/services/auth.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  var auth = AuthenticationService();
}