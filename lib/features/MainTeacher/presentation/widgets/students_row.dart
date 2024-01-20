import 'package:flutter/material.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/students_entity.dart';

class StudentsRow extends StatelessWidget {
  final Students _students;

  const StudentsRow({
    required Students students,
  }) : _students = students;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFAFAFAF)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        child: Text(
          _students.name,
          style: TextStyle(color: Color(0xFFAFAFAF), fontWeight: FontWeight.bold, fontSize: 12.0),
        ),
      ),
    );
  }
}
