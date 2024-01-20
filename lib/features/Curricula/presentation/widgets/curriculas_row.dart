import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/Curricula/domain/entities/curricula_entity.dart';
import 'package:madaresco/features/CurriculaDetails/presentation/manager/curricula_details_view_model.dart';
import 'package:madaresco/features/CurriculaDetails/presentation/pages/curricula_details_page.dart';
import 'package:madaresco/injection_container.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

class CurriculasRow extends StatelessWidget {
  final Curricular _item;

  const CurriculasRow({
    required Curricular item,
  }) : _item = item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        mainNavigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<CurriculaDetailsViewModel>(),
              child: CurriculaDetailsPage(id: _item.id),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    _item.photo,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: kAccentColor)),
                  child: Text(
                    _item.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kAccentColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
