import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Annual/domain/entities/annual_entity.dart';

class AnnualsRow extends StatelessWidget {
  final Annuals annual;

  AnnualsRow({
    required this.annual,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0)),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Text(
                  local.translate('date') + ' ' + annual.date.toString(),
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                  ),
                  color: kAccentColor,
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                child: Text(
                  local.translate('amount') + ' ' + annual.amount.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
