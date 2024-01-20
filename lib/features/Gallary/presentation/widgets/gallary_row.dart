import 'package:flutter/material.dart';
import 'package:madaresco/features/Gallary/domain/entities/gallary_entity.dart';
import 'package:madaresco/features/GallaryDetails/presentation/manager/gallary_details_view_model.dart';
import 'package:madaresco/features/GallaryDetails/presentation/pages/gallary_details_page.dart';
import 'package:madaresco/injection_container.dart';
import 'package:madaresco/main.dart';
import 'package:provider/provider.dart';

class GallaryRow extends StatelessWidget {
  final ItemEntity _item;

  GallaryRow({
    required ItemEntity item,
  }) : _item = item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        mainNavigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<GallaryDetailsViewModel>(),
              child: GallaryDetailsPage(id: _item.id),
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    child: Image.network(
                      _item.avatar,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  color: Color(0xFFF1F1F1),
                ),
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    _item.name,
                    style: TextStyle(color: Colors.black),
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
