import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String id;
  final String name;
  final String role;
  final String fromDate;
  final String toDate;

  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    required this.toDate,
  });

  factory Employee.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Employee(
      id: doc.id, // Important!
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      fromDate: data['fromDate'] ?? '',
      toDate: data['toDate'] ?? '',
    );
  }
}
