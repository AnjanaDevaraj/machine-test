import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class EmployeeCubit extends Cubit<void> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  EmployeeCubit() : super(null);

  @override
  Future<void> close() {
    nameController.dispose();
    roleController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    return super.close();
  }
}
