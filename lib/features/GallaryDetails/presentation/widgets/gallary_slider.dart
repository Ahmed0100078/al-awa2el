import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';

class GallarySlider extends StatelessWidget {
  final int _initialPage;
  final List<String> _images;

  GallarySlider({
    required int initialPage,
    required List<String> images,
  })  : _initialPage = initialPage,
        _images = images;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                mainNavigatorKey.currentState!.pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: CarouselSlider.builder(
                itemCount: _images.length,
                options: CarouselOptions(
                  initialPage: _initialPage,
                  autoPlay: false,
                  height: double.infinity,
                  enlargeCenterPage: true,
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 6 / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          _images[itemIndex],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
