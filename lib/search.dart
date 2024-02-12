import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inno_assign/model/course.dart';
import 'package:http/http.dart' as http;

class SearchPageScreen extends StatefulWidget {
  const SearchPageScreen({super.key});

  @override
  State<SearchPageScreen> createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {
  List<CourseModel> courseList = [];
  late List<CourseModel> _foundCourses;

  Future<List<CourseModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products?limit=5'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i in data) {
        courseList.add(CourseModel.fromJson(i));
      }
      return courseList;
    } else {
      return courseList;
    }
  }

  @override
  void initState() {
    super.initState();
    _foundCourses = List.from(courseList);
    getPostApi(); // Fetch data in initState
  }

  void _runFilter(String enteredKeyword) {
    setState(() {
      _foundCourses = courseList
          .where((course) => course.title!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked items'),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),

                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),

                  labelStyle: TextStyle(color: Colors.black),
                  //hintText: 'hint text',
                  //helperText: 'eg: ',

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: courseList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                    child: Container(
                                      width: 100,
                                      height: 150,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0, 0, 10, 0),
                                                      child: Container(
                                                          width: 70,
                                                          height: 100,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                          ),
                                                          child: Image.network(
                                                              courseList[index]
                                                                  .image
                                                                  .toString(),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            courseList[index]
                                                                .title
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            courseList[index]
                                                                .category
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              RatingBar.builder(
                                                                itemSize: 17,
                                                                initialRating:
                                                                    3,
                                                                minRating: 1,
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemCount: 5,
                                                                itemPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            4.0),
                                                                itemBuilder:
                                                                    (context,
                                                                            _) =>
                                                                        const Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                onRatingUpdate:
                                                                    (rating) {},
                                                              ),
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    const TextSpan(
                                                                        text:
                                                                            '(',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                    TextSpan(
                                                                      text: courseList[
                                                                              index]
                                                                          .rating!
                                                                          .rate
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    const TextSpan(
                                                                        text:
                                                                            ')',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    const TextSpan(
                                                                        text:
                                                                            '(',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                    TextSpan(
                                                                      text: courseList[
                                                                              index]
                                                                          .rating!
                                                                          .count
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    const TextSpan(
                                                                        text:
                                                                            ')',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(),
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                        1, 1),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      const TextSpan(
                                                          text: 'Rs ',
                                                          style: TextStyle(
                                                              fontSize: 17)),
                                                      TextSpan(
                                                        text: courseList[index]
                                                            .price
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Text('loading');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
