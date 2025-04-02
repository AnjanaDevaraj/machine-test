import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/employeeCubit.dart';
import '../customWidgets/customHeaderBar.dart';
import '../customWidgets/customTextField.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
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
                text: 'Add Employee Details',

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
                                SizedBox(height: 8,),
                                CustomTextField(controller: cubit.roleController, hintText: "Employee Role"),
                                SizedBox(height: 8,),
                                CustomTextField(controller: cubit.fromDateController, hintText: "From Date"),
                                SizedBox(height: 8,),
                                CustomTextField(controller: cubit.toDateController, hintText: "To Date"),
                                SizedBox(height: 8,),
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

