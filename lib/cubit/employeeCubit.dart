import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class EmployeeCubit extends Cubit<String?> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  EmployeeCubit() : super(null);

  void updateRole(String newRole) {
    roleController.text = newRole;
    emit(newRole); // Notify listeners about the change
  }

  @override
  Future<void> close() {
    nameController.dispose();
    roleController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    return super.close();
  }
}
