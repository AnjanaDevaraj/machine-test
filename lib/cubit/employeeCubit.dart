import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/employeeResponse.dart';

class EmployeeCubit extends Cubit<List<Employee>> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  EmployeeCubit() : super([]);

  void updateRole(String newRole) {
    roleController.text = newRole;
    emit([]); // Notify listeners about the change
  }

  @override
  Future<void> close() {
    nameController.dispose();
    roleController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    return super.close();
  }

  Future<void> saveEmployee(Employee? employee) async {
    try {
      if (nameController.text.isEmpty ||
          roleController.text.isEmpty ||
          fromDateController.text.isEmpty ||
          toDateController.text.isEmpty) {
        print('Enter all fields');
        return;
      }

      final data = {
        'name': nameController.text.trim(),
        'role': roleController.text.trim(),
        'fromDate': fromDateController.text.trim(),
        'toDate': toDateController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      if (employee != null && employee.id != null) {
        // Update
        await FirebaseFirestore.instance
            .collection('employees')
            .doc(employee.id)
            .update(data);
        print('Employee updated successfully');
      } else {
        // Add new
        await FirebaseFirestore.instance.collection('employees').add(data);
        print('Employee added successfully');
      }
    } catch (e) {
      print('Error saving employee: $e');
    }
  }


  Future<void> fetchEmployees() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('employees')
          .orderBy('createdAt', descending: true)
          .get();

      final employees = snapshot.docs
          .map((doc) => Employee.fromFirestore(doc))
          .toList();

      emit(employees);
    } catch (e) {
      print('Error fetching employees: $e');
      emit([]);
    }
  }


  Future<void> setEmployee(Employee? employee) async {
    if (employee != null) {
      nameController.text = employee.name;
      roleController.text = employee.role;
      fromDateController.text = employee.fromDate;
      toDateController.text = employee.toDate;
    } else {
      nameController.text = roleController.text = fromDateController.text = toDateController.text = '';
    }
    emit([]);
  }
}
