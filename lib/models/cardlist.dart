import 'package:flutter/material.dart';
import 'package:movieapp/pages/downloadpage.dart';
import 'package:movieapp/pages/movies.dart';
import 'package:movieapp/size_config.dart';
import 'package:movieapp/style/apptheme.dart';

class ListCards extends StatelessWidget {
  final Movies movies;
  const ListCards({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DownloadPage(movie: movies),
          ),
        );
      },
      child: GestureDetector(
              child: Container(
               color:AppTheme.background,
               width: double.infinity,
         
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // cover image
              Hero(
                tag:'${movies.name} ${movies.index}',
                                child: Container(
                  width: 23*SizeConfig.imageSizeMultiplier,
                  height: 18*SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${movies.image}"),
                          fit: BoxFit.cover),
                      borderRadius:
                          BorderRadius.all(const Radius.circular(15))),
                ),
              ),
              // details
              SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text("${movies.name}",
                      style: Theme.of(context).textTheme.subtitle),
                  SizedBox(height: 8),
                  Text("${movies.category}",
                      style: Theme.of(context).textTheme.body1),
                  SizedBox(height: 8),
                  Text("${movies.duration}",
                      style: Theme.of(context).textTheme.body1),
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star,
                          size: 2.5 * SizeConfig.textmultiplier,
                          color: Colors.amber.withOpacity(.9)),
                      SizedBox(width: 3),
                      Text(
                        '${movies.rating}/10',
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
