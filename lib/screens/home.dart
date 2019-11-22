import 'dart:convert';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/model/movies.dart';
import 'package:movieapp/utility/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/utility/apptheme.dart';
import 'package:movieapp/widgets/cardlist.dart';
import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movies> _movies = List<Movies>();
  List<Movies> _duplicateMovies = List<Movies>();
  Future getMovies;
  final TextEditingController _controller = new TextEditingController();

  Future<List<Movies>> fetchMovies() async {
    var url =
        'https://jsonstorage.net/api/items/37260f55-08e6-4ed8-883e-e62e274dd11d';

    var response = await http.get(url);

    var movies = List<Movies>();

    if (response.statusCode == 200) {
      var movieJson = json.decode(response.body);
      for (var i in movieJson) {
        movies.add(Movies.fromJson(i));
      }
      _movies = movies;
    }
    _duplicateMovies = movies;
    return movies;
  }

  @override
  void initState() {
    super.initState();
    getMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.background,
        body: DoubleBackToCloseApp(
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      Row(
                        children: <Widget>[
                          Text('M ',
                              style: Theme.of(context).textTheme.headline),
                          Text('4 ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(color: Colors.teal,fontSize: 5 * SizeConfig.textmultiplier)),
                          Text('U ',
                              style: Theme.of(context).textTheme.headline),
                        ],
                      ),
                      SizedBox(height: 2 * SizeConfig.heightMultiplier),
                      _searchBar(context),
                      SizedBox(height: 2 * SizeConfig.heightMultiplier),
                      _listMovies(),
                    ],
                  )),
            ),
          ),
          snackBar: const SnackBar(
            backgroundColor: Colors.black,
            duration: Duration(seconds: 1),
            content: Text(
              'Double tap to exit',
              style: TextStyle(color: Colors.teal),
            ),
          ),
        ));
  }

  Widget _listMovies() {
    return FutureBuilder(
      future: getMovies,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: _movies.length >= 25 ? 25 : _movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListCards(movies: _movies[index]),
                      );
                    },
                  )
                : Container(
                    width: double.infinity,
                    height: 500,
                    child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Center(child: Text("ERROR OCCURRED, Tap to retry !")),
                        ),
                        onTap: () => setState(() {
                          getMovies = fetchMovies();
                        })),
                  )
            : Container(
                width: double.infinity,
                height: 500,
                child: Center(child: CircularProgressIndicator()),
              );
      },
    );
  }

  Container _searchBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.5),
      decoration:
          ShapeDecoration(shape: StadiumBorder(), color: Colors.white10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 6),
          Icon(
            Icons.search,
            size: 3.3 * SizeConfig.textmultiplier,
            color: Colors.white60,
          ),
          SizedBox(width: 3),
          Expanded(
              child: TextField(
            controller: _controller,
            style: Theme.of(context).textTheme.body1,
            cursorColor: Colors.teal,
            decoration: InputDecoration(
                hintText: 'Search movies.',
                hintStyle: Theme.of(context).textTheme.body1,
                border: InputBorder.none),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(
                () {
                  _movies = _duplicateMovies
                      .where(
                        (movie) => (movie.name.toLowerCase().contains(
                              text.toLowerCase(),
                            )),
                      )
                      .toList();
                },
              );
            },
          )),
          GestureDetector(
            onTap: () {
              _controller.clear();
              setState(() {
                _movies = _duplicateMovies.toList();
              });
            },
            child: Icon(
              Icons.clear,
              size: 3 * SizeConfig.textmultiplier,
              color: Colors.white60,
            ),
          ),
          SizedBox(width: 6),
        ],
      ),
    );
  }
}
