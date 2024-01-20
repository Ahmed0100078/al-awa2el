import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Annual/domain/entities/annual_entity.dart';
import 'package:madaresco/features/Annual/presentation/widgets/annuals_row.dart';

class AnnualRow extends StatelessWidget {
  final String title;
  final List<Annuals> annuals;

  const AnnualRow({
    required this.title,
    required this.annuals,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.grey),
            ),
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: annuals.map((e) => AnnualsRow(annual: e)).toList(),
            ),
          ),
          Positioned(
            top: -16.0,
            right: 16.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
              decoration:
                  BoxDecoration(color: kAccentColor, borderRadius: BorderRadius.circular(20.0)),
              child: Text(
                local.translate(title),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
