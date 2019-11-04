import 'package:flutter/material.dart';
import 'package:movieapp/pages/downloadpage.dart';
import 'package:movieapp/pages/movies.dart';

class Cards extends StatelessWidget {
  final Movies movies;
  const Cards({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DownloadPage(movie: movies),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${movies.image}'),
                    fit: BoxFit.cover,
                  ),
                  //color: Colors.red,
                  borderRadius: BorderRadius.all(const Radius.circular(10.0))),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${movies.name}',
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }
}
