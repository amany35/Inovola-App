import 'package:carousel_slider/carousel_slider.dart';
import 'package:coursepageapitask/model/Course.dart';
import 'package:coursepageapitask/service/networking.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoursePageState();
  }
}

class _CoursePageState extends State<CoursePage> {
  CarouselSlider carouselSlider;
  int _current = 0;

  _launchURL() async {
    const url = 'https://inovola.com/en';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Future<Course> futureCourse;

  @override
  void initState() {
    super.initState();
    futureCourse = fetchCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          FutureBuilder<Course>(
            future: futureCourse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          FutureBuilder<Course>(
                            future: futureCourse,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      carouselSlider = CarouselSlider(
                                        height: 200.0,
                                        initialPage: 0,
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        reverse: false,
                                        enableInfiniteScroll: true,
                                        autoPlayInterval: Duration(seconds: 2),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 2000),
                                        pauseAutoPlayOnTouch:
                                            Duration(seconds: 10),
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index) {
                                          setState(() {
                                            _current = index;
                                          });
                                        },
                                        items: snapshot.data.img.map((img) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 0.5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Image.network(
                                                  img,
                                                  fit: BoxFit.fill,
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                );
                                /////////////////
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              return Container();
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, left: 8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Icon(
                                        Icons.star_border,
                                        size: 30.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      child: Icon(
                                        Icons.share,
                                        size: 30.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 250.0,
                                    ),
                                    Container(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 30.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 120.0)),
                                FutureBuilder<Course>(
                                  future: futureCourse,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: map<Widget>(snapshot.data.img,
                                            (index, url) {
                                          return Container(
                                            width: 10.0,
                                            height: 10.0,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 2.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _current == index
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          );
                                        }),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    return Container(
                                      child: Text(
                                        '',
                                        style: TextStyle(fontSize: 50.0),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Column(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'موسيقي#',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "Changa-Light"),
                                ),
                                FutureBuilder<Course>(
                                  future: futureCourse,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            fontFamily: "Changa-ExtraBold",
                                            fontSize: 20.0),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    return Container(
                                      child: Text(
                                        '',
                                        style: TextStyle(fontSize: 50.0),
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 24.0,
                                      color: Colors.grey[400],
                                    ),
                                    FutureBuilder<Course>(
                                      future: futureCourse,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          DateTime todayDate = DateTime.parse(
                                              snapshot.data.date);

                                          return Text(
                                            formatDate(todayDate, [
                                              yyyy,
                                              '/',
                                              mm,
                                              '/',
                                              dd,
                                              ' - ',
                                              hh,
                                              ':',
                                              nn,
                                              ':',
                                              ss,
                                              ' ',
                                              am
                                            ]),
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                                fontFamily: "Changa-Light"),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }

                                        return Container(
                                          child: Text(
                                            '',
                                            style: TextStyle(fontSize: 50.0),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Icon(
                                      Icons.pin_drop,
                                      size: 24.0,
                                      color: Colors.grey[400],
                                    ),
                                    FutureBuilder<Course>(
                                      future: futureCourse,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data.address,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey,
                                                fontFamily: "Changa-Light",
                                                fontSize: 15.0),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }

                                        return Container(
                                          child: Text(
                                            '',
                                            style: TextStyle(fontSize: 50.0),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              textDirection: TextDirection.rtl,
                              children: <Widget>[
                                FutureBuilder<Course>(
                                  future: futureCourse,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String result = '';
                                      if (snapshot.data.trainerImg ==
                                          "https://skillzycp.com/upload/trainer/389_BaseImage_636896408382239890.jpg") {
                                        // print(snapshot.data.trainerImg);
                                        result = snapshot.data.trainerImg
                                            .replaceAll('https', 'http');
                                        // print(result);
                                      }

                                      /////////////////////////////
                                      return CircleAvatar(
                                        backgroundImage: NetworkImage(result),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    return Container(
                                      child: Text(
                                        '',
                                        style: TextStyle(fontSize: 50.0),
                                      ),
                                    );
                                  },
                                ),
                                FutureBuilder<Course>(
                                  future: futureCourse,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.trainerName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[400],
                                            fontFamily: "Changa-ExtraBold",
                                            fontSize: 20.0),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    return Container(
                                      child: Text(
                                        '',
                                        style: TextStyle(fontSize: 50.0),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                FutureBuilder<Course>(
                                  future: futureCourse,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.trainerInfo,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontFamily: "Changa-Light",
                                            fontSize: 15.0),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    return Container(
                                      child: Text(
                                        '',
                                        style: TextStyle(fontSize: 50.0),
                                      ),
                                    );
                                  },
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: <Widget>[
                                Text(
                                  'عن الدورة',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[400],
                                      fontFamily: "Changa-Light",
                                      fontSize: 20.0),
                                ),
                                FutureBuilder<Course>(
                                  future: futureCourse,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.occasionDetail,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontFamily: "Changa-Light",
                                            fontSize: 15.0),
                                        textDirection: TextDirection.rtl,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    return Container(
                                      child: Text(
                                        '',
                                        style: TextStyle(fontSize: 50.0),
                                      ),
                                    );
                                  },
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: <Widget>[
                                  Text(
                                    'تكلفة الدورة',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[400],
                                        fontFamily: "Changa-Light",
                                        fontSize: 20.0),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FutureBuilder<Course>(
                                        future: futureCourse,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot
                                                  .data.reservTypes[0]['price']
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey,
                                                fontFamily: "Changa-Light",
                                                fontSize: 15.0,
                                              ),
                                              textAlign: TextAlign.left,
                                              textDirection: TextDirection.ltr,
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }
                                          return Container(
                                            child: Text(
                                              '',
                                              style: TextStyle(fontSize: 50.0),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: 250.0,
                                      ),
                                      Text(
                                        'الحجز',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                          fontFamily: "Changa-Light",
                                        ),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50.0,
                        child: SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            onPressed:_launchURL,
                            child: Text(
                              'قم بالحجز الآن',
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontFamily: "Changa-ExtraBold",
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.purple,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text("${snapshot.error}");
              }

              return Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
