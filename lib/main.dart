import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './view/home_page.dart';
import './data/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Wrapping the whole app with BlocProvider to get access to FruitBloc everywhere
    // BlocProvider extends InheritedWidget.
    return BlocProvider(
      bloc: AvengerBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
