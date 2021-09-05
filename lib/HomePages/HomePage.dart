import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HomePaged 이원재'),
      ),
    );
  }
}

class TestProvider extends ChangeNotifier{
  void testFunction(){
    print('Provider test');
  }
}
