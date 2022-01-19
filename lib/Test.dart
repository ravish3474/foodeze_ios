
import 'package:flutter/material.dart';



class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: HomePage2(),
    );
  }
}

class HomePage2 extends StatefulWidget {

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }


}


