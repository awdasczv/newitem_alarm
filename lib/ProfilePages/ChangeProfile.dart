import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
                        /*CircleAvatar(
                          radius: 80,
                          backgroundImage: _image == null ? AssetImage('assets/images/profile3.png') : FileImage(File(_image.path)),
                          //backgroundColor: Colors.transparent,
                        ),
                        /*InkWell(
                          onTap: () async {
                            PickedFile image = await _picker.getImage(source: ImageSource.gallery);
                            setState((){
                              _image = image;
                            });
                          },
                        ),*/
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: InkWell(
                            onTap: () async {
                              PickedFile image = await _picker.getImage(source: ImageSource.gallery);
                              setState((){
                                _image = image;
                              });
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.red,
                              size: 40,
                            )
                          )
                        ),*/
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 80,
                            //backgroundImage: widget.imagePath == null ? AssetImage('assets/images/profile3.png') : FileImage(File(_image.path)),
                            backgroundImage: _image == null ? widget.imagePath : FileImage(File(_image.path)),
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
}
/*PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage: _imageFile == null ? AssetImage('assets/images/profile3.png') : FileImage(File(_imageFile.path)),
            ),
            Positioned(
              //bottom: 10,
              right: 500,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.red,
                  size: 40,
                ),
              )
            )
          ],
        ),
      )
    );
  }
  Widget nameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueGrey,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.blueGrey,
        ),
        labelText: 'Name',
        hintText: 'Input your name'
      ),
    );
  }
  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: [
          Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera, size: 50),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text('Camera', style: TextStyle(fontSize: 20),),
              ),
              FlatButton.icon(
                icon: Icon(Icons.photo_library, size: 50),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text('Gallery', style: TextStyle(fontSize: 20),),
              )
            ],
          )
        ],
      )
    );
  }
  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }*/
/*
Expanded(
child: CircleAvatar(
radius: 80,
backgroundImage: AssetImage('assets/images/profile3.png'),
backgroundColor: Colors.transparent,
child: Container(
padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
child: FlatButton(
onPressed: () {},
child: Container(
color: Colors.grey,
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
"편집",
style: TextStyle(fontSize: 18),
),
],
)
)
)
),
),
)
*/