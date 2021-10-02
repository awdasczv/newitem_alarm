import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

/*class ChangeProfile extends StatefulWidget {
  final String imagePath;

  const ChangeProfile({Key key, this.imagePath}) : super(key: key);

  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  String _name;
  final textfieldController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  PickedFile _image;      //이미지 저장 변수

  void _changeName(){
    setState(() {
      _name = textfieldController.text;
    });
  }

  /*Future _getImage() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.blue,
                child: Center(
                  child: Text("프로필 변경",
                    style: TextStyle(fontSize: 20),
                    //textAlign: TextAlign.center,
                  ),
                )
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 120, 20, 120),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 80,
                            //backgroundImage: widget.imagePath == null ? AssetImage('assets/images/profile3.png') : FileImage(File(_image.path)),
                            //backgroundImage: widget.imagePath != _image ? AssetImage('assets/images/profile3.png') : FileImage(File(_image.path)),
                            backgroundImage: _image == widget.imagePath ? widget.imagePath : FileImage(File(_image.path)),
                            backgroundColor: Colors.transparent,
                          ),
                          onTap: () async {
                            PickedFile image = await _picker.getImage(source: ImageSource.gallery);
                            setState(() {
                              _image = image;
                            });
                          }
                        ),
                        SizedBox(height: 45.0),
                        TextField(
                          controller: textfieldController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder()
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context, [_image.path, textfieldController.text]);
                              },
                              child: Text('완료'),
                              //onPressed: () {},
                            )
                          ],
                        )
                      ]
                  ),
                )
            )
          ]
      ),
    );
  }
  Future _getImage() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}*/


class ChangeProfile extends StatefulWidget {
  final String imagePath;

  const ChangeProfile({Key key, this.imagePath}) : super(key: key);

  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  String _name;
  final textfieldController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  PickedFile _image;      //이미지 저장 변수

  void _changeName(){
    setState(() {
      _name = textfieldController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.blue,
                child: Center(
                  child: Text("프로필 변경",
                    style: TextStyle(fontSize: 20),
                    //textAlign: TextAlign.center,
                  ),
                )
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 120, 20, 120),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            child: CircleAvatar(
                              radius: 80,
                              //backgroundImage: widget.imagePath == null ? AssetImage('assets/images/profile3.png') : FileImage(File(_image.path)),
                              //backgroundImage: widget.imagePath != _image ? AssetImage('assets/images/profile3.png') : FileImage(File(_image.path)),
                              backgroundImage: _image == null ? AssetImage('assets/images/profile3.png') : FileImage(File(_image.path)),
                              backgroundColor: Colors.transparent,
                            ),
                            onTap: () {
                              showDialog(context: context, builder: ((builder) => _showDialog()));
                            }
                        ),
                        SizedBox(height: 45.0),
                        TextField(
                          controller: textfieldController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder()
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context, [_image.path, textfieldController.text]);
                              },
                              child: Text('완료'),
                              //onPressed: () {},
                            )
                          ],
                        )
                      ]
                  ),
                )
            )
          ]
      ),
    );
  }
  Widget _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("카메라 및 사진"),
          actions: <Widget>[
            Column(
              children: [
                new ElevatedButton.icon(
                  icon: Icon(Icons.camera, size: 50,),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  label: Text("카메라로 사진 촬영", style: TextStyle(fontSize:20),),
                ),
                new ElevatedButton.icon(
                  icon: Icon(Icons.photo_library, size: 50,),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: Text("앨범에서 사진 선택", style: TextStyle(fontSize: 20),),
                )
              ],
            )
          ]
        );
      }
    );
  }
  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _image = pickedFile;
    });
  }
  Future _getImage() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
