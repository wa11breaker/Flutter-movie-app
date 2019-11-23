import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movieapp/model/movies.dart';
import 'package:movieapp/utility/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadPage extends StatelessWidget {
  final Movies movie;

  DownloadPage({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        ///top: false,
        child: new ColumnDetails(
          movie: movie,
        ),
      ),
    );
  }
}

class ColumnDetails extends StatelessWidget {
  final Movies movie;

  const ColumnDetails({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${movie.image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: '${movie.name} ${movie.index}',
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.5,
                    // color: Colors.red,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all((const Radius.circular(10))),
                          image: DecorationImage(
                            image: NetworkImage("${movie.image}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: SizeConfig.imageSizeMultiplier * 60,
                        height: SizeConfig.heightMultiplier * 52,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DownloadPage(movie: null)));
                      },
                      child: Icon(
                        (Icons.arrow_back),
                        size: 4 * SizeConfig.textmultiplier,
                      )),
                )
              ],
            ),

            // Movie Tile
            Positioned(
              bottom: 10,
              left: 20,
              child: Text(
                movie.name,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Text(
                'Category : ${movie.category}',
                style: Theme.of(context).textTheme.body1,
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Text(
                "Duration : ${movie.duration}, ",
                style: Theme.of(context).textTheme.body1,
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Text(
                "Rating : ${movie.rating}/10",
                style: Theme.of(context).textTheme.body1,
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 3),
              Row(
                children: <Widget>[
                  OutlineButton(
                      borderSide: BorderSide(color: Colors.teal),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(7),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      textColor: Colors.white,
                      onPressed: () {
                        _download480(movie.link480);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "Download 480p",
                          style: Theme.of(context).textTheme.body1,
                        ),
                      )),
                  SizedBox(width: SizeConfig.imageSizeMultiplier * 4),
                  OutlineButton(
                      borderSide: BorderSide(color: Colors.teal),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(7),
                      ),
                      padding: const EdgeInsets.all(5.0),
                      textColor: Colors.white,
                      onPressed: () {
                        _download720(movie.link720);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text("Download 720p",
                            style: Theme.of(context).textTheme.body1),
                      )),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

_download480(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
}

_download720(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
}
