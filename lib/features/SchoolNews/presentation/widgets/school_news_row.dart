import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/SchoolNews/domain/entities/school_news_entity.dart';
import 'package:madaresco/features/SchoolNewsDetails/presentation/manager/school_news_details_view_model.dart';
import 'package:madaresco/features/SchoolNewsDetails/presentation/pages/school_news_details_page.dart';
import 'package:madaresco/injection_container.dart';
import 'package:provider/provider.dart';

class SchoolNewsRow extends StatelessWidget {
  final NewsEntity _news;

  SchoolNewsRow({
    required NewsEntity news,
  }) : _news = news;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<SchoolNewsDetailsViewModel>(),
              child: SchoolNewsDetailsPage(
                id: _news.id,
                photos: _news.photos.length != 0 ? _news.photos : [],
              ),
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 29.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            _news.image,
                            height: 90,
                            fit: BoxFit.fill,
                            width: 90,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              _news.date,
                              style: TextStyle(
                                  color: Color(0xFF6C6C6C), fontSize: 12),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _news.title,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/vision.png',
                                  height: 8,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Text(
                                    _news.number.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  top: -20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kAccentColor,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/essay.png',
                      height: 25,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
