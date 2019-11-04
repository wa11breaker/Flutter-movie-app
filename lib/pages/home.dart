import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movieapp/style/apptheme.dart';
//import 'package:movieapp/models/cards.dart';
import 'package:movieapp/models/cardlist.dart';
import 'package:movieapp/pages/movies.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/size_config.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movies> _movies = List<Movies>();
  List<Movies> _moviesForDisplay = List<Movies>();

  Future<List<Movies>> fetchMovies() async {
    var url = 'https://next.json-generator.com/api/json/get/N1VZFTo_P';

    var response = await http.get(url);

    var movies = List<Movies>();

    if (response.statusCode == 200) {
      var movieJson = json.decode(response.body);
      for (var noteJson in movieJson) {
        movies.add(Movies.fromJson(noteJson));
      }
    }
    return movies;
  }

  @override
  void initState() {
    fetchMovies().then((value) {
      setState(() {
        _movies.addAll(value);
        _moviesForDisplay = _movies;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('M 4 U', style: Theme.of(context).textTheme.headline),
                SizedBox(height: 2 * SizeConfig.heightMultiplier),
                /////   search bar      /////////////////////////////////
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.5),
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(), color: Colors.white10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 3),
                      Icon(
                        Icons.search,
                        size: 3.3 * SizeConfig.textmultiplier,
                        color: Colors.white60,
                      ),
                      SizedBox(width: 3),
                      Expanded(
                          child: TextField(
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(
                            hintText: 'Search movies.',
                            hintStyle: Theme.of(context).textTheme.body1,
                            border: InputBorder.none),
                        onChanged: (text) {
                          text = text.toLowerCase();
                          setState(
                            () {
                              _moviesForDisplay = _movies
                                  .where((movie) => (movie.name
                                      .toLowerCase()
                                      .contains(text.toLowerCase())))
                                  .toList();
                            },
                          );
                        },
                      )),
                    ],
                  ),
                ),

                // list view builder
                SizedBox(height: 2 * SizeConfig.heightMultiplier),
                Expanded(
                  child: (_moviesForDisplay.length == 0)
                      ? Center(
                        child: CircularProgressIndicator(),
                      )

                      : ListView.builder(
                          //physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: _moviesForDisplay.length>=25?25:_moviesForDisplay.length,

                          //physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new ListCards(
                                movies: _moviesForDisplay[index],
                              ),
                            );
                          },
                        ),
                ),
              ],
            )),
      ),
    );
  }
}

/*
    SizedBox(height: 10),
                  Text('Popular', style: Theme.of(context).textTheme.title),
                  SizedBox(height: 10),
                  Container(
                    height: 220,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: _moviesForDisplay.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Cards(
                          movies: _moviesForDisplay[index],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Recent', style: Theme.of(context).textTheme.title),*/
