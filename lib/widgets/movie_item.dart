import 'dart:math';
import 'package:first_movie_app/models/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;
  final double pageNumber;
  final double index;

  MovieItem(this.movie, this.pageNumber, this.index);

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> with SingleTickerProviderStateMixin{

  Animation<double> ? hightAnim;
  Animation<double> ? scaleAnim;
  Animation<double> ? yOffsetAnim;
  Animation<double> ? elevAnim;
  late AnimationController controller;

  @override
  void initState(){
    controller = AnimationController(duration : Duration(seconds: 1), vsync: this);
    controller.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    hightAnim = Tween(begin: 0.0, end: 150.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.5, 1.0, curve: Curves.bounceIn),)) as Animation<double>;

    scaleAnim = Tween(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.3, curve: Curves.bounceIn),)) as Animation<double>;

    yOffsetAnim = Tween(begin: 1.0, end: 10.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.3, curve: Curves.bounceIn),)) as Animation<double>;

    elevAnim = Tween(begin: 2.0, end: 10.0).animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.3, curve: Curves.bounceIn),)) as Animation<double>;

    super.didChangeDependencies();
  }

  bool isExpanded=false;
  @override
  Widget build(BuildContext context) {
    double diff = widget.index - widget.pageNumber;
    return Transform(transform: Matrix4.identity()
    ..setEntry(3, 2, 0.002)
    ..rotateY(-pi/4*diff),
    alignment: diff > 0 ? FractionalOffset.centerLeft: FractionalOffset.centerRight,
    child: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 500,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.movie.name, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
            background: Image.asset(widget.movie.image, width: double.infinity, height: 1200, fit: BoxFit.cover,),
          ),
        ),
        SliverList(delegate: SliverChildListDelegate([
          Stack(
            children: [
              Card(
                color: Colors.cyan.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular((15))
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 100, right: 10, bottom: 10),
                  child: Text(widget.movie.description, style: TextStyle(fontSize: 18, color: Colors.white),),
                ),
              ),
              Transform.scale(scale: scaleAnim!.value,
              child: Container(
                margin:  EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: elevAnim!.value,
                      spreadRadius: 1,
                      offset: Offset(0, yOffsetAnim!.value)
                    )
                  ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(widget.movie.name, style: TextStyle(fontSize: 18, color: Colors.white),),
                      subtitle: Text(widget.movie.category, style: TextStyle(fontSize: 18, color: Colors.white),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('${widget.movie.rating}', style: TextStyle(fontSize: 18, color: Colors.white),)
                        ],
                      ),
                      onTap: (){
                        if(isExpanded){
                          controller.reverse();
                        }
                        else{
                          controller.forward();
                        }
                        setState(() {
                          isExpanded = ! isExpanded;
                        });
                      },
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black87,
                              Colors.black45
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        ),
                        alignment: Alignment.center,
                        height: hightAnim!.value,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width/ 1.5,
                          child: ListView(
                            children: [
                              Text('Directed by  : ${widget.movie.director}', style: TextStyle(fontSize: 18, color: Colors.white),),
                              Text('Produced by  : ${widget.movie.producer}', style: TextStyle(fontSize: 18, color: Colors.white),),
                              Text('Production   : ${widget.movie.production}', style: TextStyle(fontSize: 18, color: Colors.white),),
                              Text('Language     : ${widget.movie.language}', style: TextStyle(fontSize: 18, color: Colors.white),),
                              Text('Running Time : ${widget.movie.runningTime}', style: TextStyle(fontSize: 18, color: Colors.white),),
                              Text('Country      : ${widget.movie.country}', style: TextStyle(fontSize: 18, color: Colors.white),),
                              Text('Budget       : ${widget.movie.budget}', style: TextStyle(fontSize: 18, color: Colors.white),),
                              Text('BoxOffice    : ${widget.movie.boxOffice}', style: TextStyle(fontSize: 18, color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),)
            ],
          )
        ]))
      ],
    ),);
  }
}
