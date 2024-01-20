import 'package:flutter/material.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/SmoothPageIndicator/src/effects/expanding_dots_effect.dart';
import 'package:madaresco/core/SmoothPageIndicator/src/smooth_page_indicator.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Login/presentation/pages/login_page.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';

import '../../injection_container.dart';

class SlidePages extends StatefulWidget {
  SlidePages({Key? key}) : super(key: key);

  @override
  _SlidePagesState createState() => _SlidePagesState();
}

class _SlidePagesState extends State<SlidePages> {
  PreloadPageController? _controller;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _controller = PreloadPageController();
    SharedPreference.setIsFirstTime(false);
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Material(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                SharedPreference.setIsFirstTime(false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => sl<LoginViewModel>(),
                      child: LoginPage(),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  local.translate('skip'),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFF646464),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: PreloadPageView(
                controller: _controller,
                physics: AlwaysScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    pageNumber = index;
                  });
                },
                preloadPagesCount: 3,
                children: <Widget>[
                  Image.asset('assets/images/slide1.png'),
                  Image.asset('assets/images/slide3.png'),
                  Image.asset('assets/images/slide2.png'),
                ],
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: _controller!, // PageController
                count: 3,
                effect: ExpandingDotsEffect(
                    radius: 18.0,
                    dotHeight: 12,
                    dotWidth: 12,
                    expansionFactor: 5.0,
                    activeDotColor: Color.lerp(Color(0xFF001068),
                        Color(0xFF001068), 0.6)!), // your preferred effect
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              getTitle(pageNumber, local),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF001068),
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                getSubText(pageNumber, local),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF585858),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: ElevatedButton(
                onPressed: () {
                  SharedPreference.setIsFirstTime(false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        create: (_) => sl<LoginViewModel>(),
                        child: LoginPage(),
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0))),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(0.0)),
                  textStyle: MaterialStateProperty.all<TextStyle?>(
                      TextStyle(color: Colors.white)),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: kBoxDecoration.copyWith(
                      borderRadius: BorderRadius.all(Radius.circular(87.0))),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Center(
                      child: Text(local.translate('start_now'),
                          style: TextStyle(fontSize: 20))),
                ),
              ),
            ),
            SizedBox(
              height: 26,
            )
          ],
        ),
      ),
    );
  }

  String getSubText(int pageNum, AppLocalizations local) {
    switch (pageNum) {
      case 0:
        return local.translate('fdesc');
      case 1:
        return local.translate('sdesc');
      case 2:
        return local.translate('tdesc');
      default:
        return '';
    }
  }

  String getTitle(int pageNum, AppLocalizations local) {
    switch (pageNum) {
      case 0:
        return local.translate('watch');
      case 1:
        return local.translate('contact');
      case 2:
        return local.translate('daily_homework');
      default:
        return '';
    }
  }
}
