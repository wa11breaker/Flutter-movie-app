import 'package:flutter/material.dart';
import 'package:movieapp/screens/home.dart';
import 'package:movieapp/utility/apptheme.dart';
import 'package:movieapp/utility/size_config.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              
              title: 'M 4 U',
              theme: ThemeData(
               
                brightness: Brightness.dark,
                primarySwatch: Colors.red,
                textTheme: TextTheme(
                  headline: TextStyle(
                      fontSize: 3.8 * SizeConfig.textmultiplier,
                      fontWeight: FontWeight.w500,
                      ),
                  title: TextStyle(
                      fontSize: 3.1 * SizeConfig.textmultiplier,
                      color: AppTheme.primarytext.withOpacity(.8),
                      fontWeight: FontWeight.w400),
                  subtitle: TextStyle(
                      fontSize: 2.2 * SizeConfig.textmultiplier,
                      color: Colors.white),
                  body1: TextStyle(
                      fontSize: 1.8 * SizeConfig.textmultiplier,
                      fontWeight: FontWeight.w400,
                      color: Colors.white60),
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: MyHomePage(),
            );
          },
        );
      },
    );
  }
}
