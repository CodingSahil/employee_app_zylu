import 'dart:developer';

import 'package:employee_app_zylu/controllers/home_controller.dart';
import 'package:employee_app_zylu/models/employee_model.dart';
import 'package:employee_app_zylu/views/component/add_edit_employee_bottomsheet.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool loader = true;
  HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Employee List",
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
        future: homeController.getEmployeeList(),
        builder: (context, snapshot) {
          log("snapshot => ${snapshot.data}");
          return homeController.isLoading
              ? Center(
                  child: SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                  ),
                )
              : snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          bool? result = await addEditEmployeeBottomSheet(
                            context,
                            addEditEmployee: AddEditEmployee.addEmployee,
                            homeController: homeController,
                          );
                          log("result => $result");
                          if (result != null && result) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20, right: 16),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.black),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 20),
                              SizedBox(width: 6),
                              Text(
                                "Add",
                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        itemBuilder: (context, index) {
                          EmployeeModel employee = snapshot.data![index];
                          bool isActive = employee.isActive && employee.yearsOfService > 5;
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              bool? result = await addEditEmployeeBottomSheet(
                                context,
                                addEditEmployee: AddEditEmployee.editEmployee,
                                homeController: homeController,
                                employeeModel: employee,
                              );
                              log("result => $result");
                              if (result != null && result) {
                                setState(() {});
                              }
                            },
                            child: Stack(
                              children: [
                                if (isActive)
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "Active",
                                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha((255 * 0.2).toInt()),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        employee.name,
                                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.black),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            "Years Of Service:",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black.withAlpha((255 * 0.5).toInt()),
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            employee.yearsOfService.toString(),
                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
                  ),
                );
        },
      ),
    );
  }
}
