import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management_task/customWidgets/customText.dart';
import 'package:employee_management_task/utilities/appAssets.dart';
import 'package:employee_management_task/view/addEmployee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubit/employeeCubit.dart';
import '../customWidgets/customHeaderBar.dart';
import '../models/employeeResponse.dart';

class ListEmployees extends StatefulWidget {
  @override
  _ListEmployeesState createState() => _ListEmployeesState();
}

class _ListEmployeesState extends State<ListEmployees> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<EmployeeCubit>().fetchEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddEmployee(),
                ),
              );
            }),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              const CustomHeader(
                text: 'Employee List',
              ),
              Expanded(
                child: BlocBuilder<EmployeeCubit, List<Employee>>(
                  builder: (context, employeeList) {
                   if (employeeList.isEmpty) {
                      return Container(
                        color: Colors.grey[100],
                          child: Center(child: Image.asset(AppAssets.noEmployee, width: 200,height: 200,)));
                    }

                   final dateFormatter = DateFormat('dd MMM yyyy');

                   final currentEmployees = employeeList.where((emp) {
                     final toDateStr = emp.toDate;
                     if (toDateStr.trim().isEmpty) {
                       return true;
                     }

                     try {
                       final toDate = dateFormatter.parse(toDateStr);
                       return !toDate.isBefore(DateTime.now());
                     } catch (_) {
                       return true;
                     }
                   }).toList();


                   final previousEmployees = employeeList.where((emp) {
                      try {
                        final toDate = dateFormatter.parse(emp.toDate ?? '');
                        return toDate.isBefore(DateTime.now());
                      } catch (_) {
                        return false;
                      }
                    }).toList();
      
                    return ListView(
                      children: [
                        Container(
                            color: Colors.grey[200],
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child: CustomText(text: 'Current Employees', color: Colors.blue),
                            )),
                        const SizedBox(height: 8),
                        if (currentEmployees.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: CustomText(text: 'No current employees!'),
                          )
                        else
                          ...currentEmployees.map((emp) => Dismissible(
                                key: Key(emp.id),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  color: Colors.red,
                                  child: const Icon(Icons.delete, color: Colors.white),
                                ),
                                onDismissed: (direction) async {
                                  try {
                                    await FirebaseFirestore.instance.collection('employees').doc(emp.id).delete();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Employee data has been deleted')),
                                    );
                                    await context.read<EmployeeCubit>().fetchEmployees();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Failed to delete: $e')),
                                    );
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => AddEmployee(employee: emp),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: CustomText(text: emp.name, size: 16,weight: FontWeight.w500,),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(text:  emp.role, color: Colors.grey,),
                                        CustomText(text: "From: ${emp.fromDate}", color: Colors.grey,),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        const SizedBox(height: 24),
                        Container(
                            color: Colors.grey[200],
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child: CustomText(text: 'Previous Employees', color: Colors.blue),
                            )),
                        const SizedBox(height: 8),
                        if (previousEmployees.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: CustomText(text: 'No previous employees!'),
                          )
                        else
                          ...previousEmployees.map((emp) => Dismissible(
                                key: Key(emp.id),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  color: Colors.red,
                                  child: const Icon(Icons.delete, color: Colors.white),
                                ),
                                onDismissed: (direction) async {
                                  try {
                                    await FirebaseFirestore.instance.collection('employees').doc(emp.id).delete();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Employee deleted successfully')),
                                    );
                                    await context.read<EmployeeCubit>().fetchEmployees();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Failed to delete: $e')),
                                    );
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => AddEmployee(employee: emp),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: CustomText(text: emp.name, size: 16,weight: FontWeight.w500,),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(text: " ${emp.role}", color: Colors.grey,),
                                        CustomText(text: "${emp.fromDate} - ${emp.toDate}", color: Colors.grey,),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                      ],
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey[200],
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: CustomText(
                        text: 'Swipe left to delete',
                        color: Colors.grey[600],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
