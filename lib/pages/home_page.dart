import 'package:first_movie_app/database/db.dart';
import 'package:first_movie_app/widgets/movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  double pageNumber = 0.0;
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 1);
    pageController.addListener(() {
      setState(() {
        pageNumber = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/theme.jpg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          PageView.builder(
              itemBuilder: (context, index) =>
                  (MovieItem(movies[index], pageNumber, index.toDouble())),
              controller: pageController,
              itemCount: movies.length)
        ],
      ),
    ));
  }
}
