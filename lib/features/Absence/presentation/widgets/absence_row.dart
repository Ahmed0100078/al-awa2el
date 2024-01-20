import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/Absence/domain/entities/absence_entity.dart';

class AbsenceRow extends StatelessWidget {
  final AbsenceData _data;

  AbsenceRow({
    required AbsenceData data,
  }) : _data = data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kAccentColor,
              ),
              child: Text(
                _data.day,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black45),
              ),
              child: Text(
                _data.date,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black45),
              ),
              child: Text(
                _data.statuses,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
