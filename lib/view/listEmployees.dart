import 'package:employee_management_task/customWidgets/customDateTimePicker.dart';
import 'package:employee_management_task/customWidgets/customTextButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/employeeCubit.dart';
import '../customWidgets/customDropdown.dart';
import '../customWidgets/customHeaderBar.dart';
import '../customWidgets/customTextField.dart';
import '../utilities/appStrings.dart';

class ListEmployees extends StatefulWidget {
  @override
  _ListEmployeesState createState() => _ListEmployeesState();
}

class _ListEmployeesState extends State<ListEmployees> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              const CustomHeader(
                text: 'Employee List',

              ), Expanded(
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
                                SizedBox(height: 16),
                                CustomDropdown<String>(
                                  hintText: "Select role",
                                  items: AppStrings.roles,
                                  value: cubit.roleController.text, // Your selected value state
                                  onChanged: (newValue) {
                                    context.read<EmployeeCubit>().updateRole(newValue ?? "");
                                  },
                                ),
                                SizedBox(height: 16),
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
      ),
    );
  }
}

