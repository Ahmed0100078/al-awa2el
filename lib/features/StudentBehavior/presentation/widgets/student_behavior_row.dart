import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/StudentBehavior/domain/entities/student_behavior_entity.dart';

class StudentBehaviorRow extends StatelessWidget {
  final Warning? warning;
  const StudentBehaviorRow({this.warning});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                warning!.title,
                style: TextStyle(color:kAccentColor),
                maxLines: 2,
              ),
              Text(
                warning!.date,
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
