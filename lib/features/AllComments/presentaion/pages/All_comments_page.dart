import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/widgets/custom_comment_text_Field.dart';

class AllCommentsPage extends StatefulWidget {
  @override
  _AllCommentsPageState createState() => _AllCommentsPageState();
}

class _AllCommentsPageState extends State<AllCommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 150,
              child: Material(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0)),
                child: AppBar(
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        const Color(0xFF001068),
                        const Color(0xFF001068),
                      ],
                    )),
                  ),
                  actions: [
                    GestureDetector(
                      child: Transform.rotate(
                          angle: 1.571 * 2,
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                              })),
                    ),
                  ],
                  leading: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Image.asset(
                        'assets/images/menu.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    ' جميع التعليقات',
                    style: GoogleFonts.cairo(
                        fontSize: 16.0, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            bottom: 10,
            right: 10,
            left: 10,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .55,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: AssetImage(
                                            'assets/images/placeholder.png'),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Text('studentName')
                                              ],
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .6,
                                                child: Text('comment')),
                                            SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text('3.400'),
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) =>
                              Divider(thickness: 1),
                          itemCount: 10),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/placeholder.png'),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CustomCommentTextField(
                                // onChanged: (_) {},
                                // onSubmitted: (_) {},
                                ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
