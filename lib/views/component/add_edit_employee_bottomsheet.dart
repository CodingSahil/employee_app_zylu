import 'package:employee_app_zylu/controllers/home_controller.dart';
import 'package:employee_app_zylu/models/employee_model.dart';
import 'package:employee_app_zylu/views/component/text-field/labeled_app_text_field.dart';
import 'package:flutter/material.dart';

enum AddEditEmployee { addEmployee, editEmployee }

Future<bool?> addEditEmployeeBottomSheet(
  BuildContext context, {
  required AddEditEmployee addEditEmployee,
  required HomeController homeController,
  EmployeeModel? employeeModel,
}) async {
  return await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.white,
    scrollControlDisabledMaxHeightRatio: 0.95,
    showDragHandle: true,
    isDismissible: false,
    isScrollControlled: false,
    builder: (context) {
      return AddEditEmployeeComponent(
        addEditEmployee: addEditEmployee,
        homeController: homeController,
        employeeModel: employeeModel,
      );
    },
  );
}

class AddEditEmployeeComponent extends StatefulWidget {
  const AddEditEmployeeComponent({
    super.key,
    required this.addEditEmployee,
    required this.homeController,
    this.employeeModel,
  });

  final AddEditEmployee addEditEmployee;
  final EmployeeModel? employeeModel;
  final HomeController homeController;

  @override
  State<AddEditEmployeeComponent> createState() => _AddEditEmployeeComponentState();
}

class _AddEditEmployeeComponentState extends State<AddEditEmployeeComponent> {
  late final TextEditingController nameController;
  late final TextEditingController yearsOfServiceController;
  bool isSwitchOn = false;
  bool buttonLoader = false;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.employeeModel?.name);
    yearsOfServiceController = TextEditingController(text: widget.employeeModel?.yearsOfService.toString());
    isSwitchOn = widget.employeeModel?.isActive ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.only(top: 14, bottom: 14 + MediaQuery.viewInsetsOf(context).bottom, right: 20, left: 20),
      child: Column(
        spacing: 15,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${widget.addEditEmployee == AddEditEmployee.editEmployee ? "Edit" : "Add"} Employee",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.black),
          ),
          Divider(color: Colors.black.withAlpha((255 * 0.25).toInt()), height: 0.5, thickness: 0.5),
          LabeledAppTextField(
            label: "Name",
            controller: nameController,
            onChanged: (value) => setState(() {}),
            onFieldSubmitted: (value) => setState(() {}),
            textInputType: TextInputType.text,
          ),
          LabeledAppTextField(
            label: "Years of Service",
            controller: yearsOfServiceController,
            onChanged: (value) => setState(() {}),
            onFieldSubmitted: (value) => setState(() {}),
            textInputType: TextInputType.numberWithOptions(signed: true),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Active",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Switch(
                  value: isSwitchOn,
                  activeColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      isSwitchOn = !isSwitchOn;
                    });
                  },
                ),
              ],
            ),
          ),
          StatefulBuilder(
            builder: (context, setInnerState) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  setInnerState(() {
                    buttonLoader = true;
                  });
                  if (widget.addEditEmployee == AddEditEmployee.editEmployee && widget.employeeModel != null) {
                    await widget.homeController.editEmployee(
                      employee: EmployeeModel(
                        id: widget.employeeModel!.id,
                        name: nameController.text,
                        yearsOfService: num.parse(yearsOfServiceController.text),
                        isActive: isSwitchOn,
                      ),
                    );
                  } else {
                    await widget.homeController.addEmployee(
                      employee: EmployeeModel(
                        id: widget.homeController.listLength + 1,
                        name: nameController.text,
                        yearsOfService: num.parse(yearsOfServiceController.text),
                        isActive: isSwitchOn,
                      ),
                    );
                  }
                  setInnerState(() {
                    buttonLoader = true;
                  });
                  await Future.delayed(Duration(milliseconds: 500));
                  Navigator.pop(context, true);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: buttonLoader
                      ? Center(
                          child: SizedBox(
                            height: 12,
                            width: 12,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          ),
                        )
                      : Text(
                          widget.addEditEmployee == AddEditEmployee.editEmployee ? "Update Employee" : "Add Employee",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                ),
              );
            },
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
