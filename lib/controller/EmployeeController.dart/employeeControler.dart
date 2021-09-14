import 'package:get/get.dart';
import 'package:tracer/db.dart';
import 'package:tracer/models.dart/employee.dart';

class EmployeeController extends GetxController {
  static EmployeeController instance = Get.find();
  late Employee employee;
  // ignore: non_constant_identifier_names
  RxList<Employee> profile = RxList<Employee>([]);
  RxList<Employee> employeelist = RxList<Employee>([]);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    employeelist.bindStream(
      fetchEmployee(),
    );
  }

  Stream<List<Employee>> fetchEmployee() => users.snapshots().map(
        (event) => event.docs
            .map(
              (e) => Employee.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );
}
