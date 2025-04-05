import 'package:employee_management_task/customWidgets/customDateTimePicker.dart';
import 'package:employee_management_task/customWidgets/customText.dart';
import 'package:employee_management_task/customWidgets/customTextButton.dart';
import 'package:employee_management_task/view/listEmployees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/employeeCubit.dart';
import '../customWidgets/customDropdown.dart';
import '../customWidgets/customHeaderBar.dart';
import '../customWidgets/customTextField.dart';
import '../models/employeeResponse.dart';
import '../utilities/appStrings.dart';

class AddEmployee extends StatefulWidget {
  //Project Console: https://console.firebase.google.com/project/employeemanagement-38629/overview
  // Hosting URL: https://employeemanagement-38629.web.app
  Employee? employee;

  AddEmployee({super.key, this.employee});

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<EmployeeCubit>().setEmployee(widget.employee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 100,
            child: CustomTextButton(
              minWidth: 50,
              text: "Cancel",
              color: Colors.grey[300]!,
              textColor: Colors.blue,
              textSize: 16,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ListEmployees(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8), // Spacing between buttons
          SizedBox(
            width: 100,
            child: CustomTextButton(
              minWidth: 50,
              text: "Save",
              color: Colors.blue,
              textSize: 16,
              onPressed: () async {
                final cubit = context.read<EmployeeCubit>();
                await cubit.saveEmployee(widget.employee);
                await cubit.fetchEmployees();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ListEmployees(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const CustomHeader(
              text: 'Add Employee Details',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    children: [
                      BlocBuilder<EmployeeCubit, void>(
                        builder: (context, state) {
                          final cubit = context.read<EmployeeCubit>();
                          return Column(
                            children: [
                              CustomTextField(controller: cubit.nameController, hintText: "Employee Name"),
                              const SizedBox(height: 16),
                              CustomDropdown<String>(
                                hintText: "Select role",
                                items: AppStrings.roles,
                                value: cubit.roleController.text,
                                onChanged: (newValue) {
                                  context.read<EmployeeCubit>().updateRole(newValue ?? "");
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomDatePickerField(
                                    controller: cubit.fromDateController,
                                    isToDate: null,
                                    hintText: 'Today',
                                  )),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                      child: CustomDatePickerField(
                                    isToDate: true,
                                    controller: cubit.toDateController,
                                    hintText: 'No Date',
                                  )),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
