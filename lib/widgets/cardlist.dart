import 'package:flutter/material.dart';
import 'package:movieapp/model/movies.dart';
import 'package:movieapp/screens/downloadpage.dart';
import 'package:movieapp/utility/size_config.dart';

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
          //Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: DownloadPage(movie: movies)));
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 20 * SizeConfig.heightMultiplier,
          child: Row(
            children: <Widget>[
              image(),
              details(context),
            ],
          ),
        ));
  }

  Widget details(BuildContext context) {
    return Container(
      width: 60 * SizeConfig.imageSizeMultiplier,
      height: 17.5 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(4), bottomRight: Radius.circular(4))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text("${movies.name}", style: Theme.of(context).textTheme.subtitle),
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
      ),
    );
  }

  Hero image() {
    return Hero(
        tag: '${movies.name} ${movies.index}',
        child: Container(
          height: 20 * SizeConfig.heightMultiplier,
          width: 27 * SizeConfig.imageSizeMultiplier,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
                image: NetworkImage('${movies.image}'), fit: BoxFit.cover),
          ),
        ));
  }
}
