import 'package:flutter/material.dart';
//import 'views/second_page.dart';
import 'models/drawner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Drawer Demo'),
      ),
      drawer: Drawner(),//ilmportation du drawer
      body: Center(
        child: Text('Welcome to Flutter Drawer Demo'),
      ),
    );
  }
}



