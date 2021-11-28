import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const List<String> input_data = [];
  final textController = TextEditingController();
  static const List<String> test = ["1", "2", "3", "4"];

  void _put() {
    setState(() {
      input_data.add(textController.text);
    });
  }

  void _clear() {
    setState(() {
      input_data.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }

  Widget _buildStaticListView() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: test.length,
        itemBuilder: (BuildContext _ctx, int i) {
          return ListTile(
            title: Text(test[i], style: TextStyle(fontSize: 23),),

          );
        }
    );
  }

}
