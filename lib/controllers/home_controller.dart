import 'dart:convert';
import 'dart:developer';

import 'package:employee_app_zylu/models/employee_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController {
  bool isLoading = false;
  int listLength = 0;

  Future<List<EmployeeModel>> getEmployeeList() async {
    List<EmployeeModel> employeeList = [];

    isLoading = true;
    await Supabase.instance.client.from("employees").select().then((value) {
      log("employees => $value");
      for (var element in value) {
        EmployeeModel employeeModel = EmployeeModel.fromJson(element);
        employeeList.add(employeeModel);
      }
    });
    employeeList.sort((a, b) => (a.id ?? 0).compareTo((b.id ?? 0)));
    listLength = employeeList.length;
    isLoading = false;
    return employeeList;
  }

  Future<void> addEmployee({required EmployeeModel employee}) async {
    log("Request => ${jsonEncode(employee.toJson())}");
    await Supabase.instance.client.from("employees").insert(employee.toJson()).then((value) {
      log("add employee => $value");
    });
  }

  Future<void> editEmployee({required EmployeeModel employee}) async {
    await Supabase.instance.client.from("employees").update(employee.toJson()).eq("id", employee.id ?? -100).then((value) {
      log("edit employee => $value");
    });
  }
}
