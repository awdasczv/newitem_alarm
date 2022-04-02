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
  String _im;
  final textfieldController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  PickedFile _image;      //이미지 저장 변수

  void _changeName(){
    setState(() {
      _name = textfieldController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _im = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.white,
                child: Center(
                  child: Text("프로필 변경",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black
                    ),
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
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(),
                              shape: BoxShape.circle
                          ),
                          child: GestureDetector(
                              child: Hero(
                                tag: "profileImage",
                                child: CircleAvatar(
                                  radius: 80,
                                  //backgroundImage: widget.imagePath == null ? AssetImage('assets/images/profile3.png') : FileImage(File(_image.path)),
                                  //backgroundImage: widget.imagePath != _image ? AssetImage('assets/images/profile3.png') : FileImage(File(_image.path)),
                                  backgroundImage: _im.length == 0 ? AssetImage('assets/images/profile3.png') : FileImage(File(_im)),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              onTap: () {
                                _showDialog();
                              }
                          ),
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
                              child: Hero(
                                tag: "submit",
                                child: Text("완료")
                              ),
                              onPressed: (){
                                Navigator.pop(context, [_im, textfieldController.text]);
                              },
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
  Widget _showDialog() {              //카메라 및 사진 팝업창 표시 함수
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(                //팝업창 모서리 둥글게
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: new Text("카메라 및 사진", style: TextStyle(fontWeight: FontWeight.bold),),      //팝업창 제목
          content: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new TextButton(                   //카메라로 사진 촬영 버튼 생성
                  child: Hero(
                    tag: "camera",
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("카메라로 사진 촬영", style: TextStyle(fontSize: 17, color: Colors.black), textAlign: TextAlign.start),
                      )
                  ),
                  onPressed: () async {
                    await takePhoto(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                new TextButton(                     // 앨범에서 사진 선택 버튼 생성
                  child: Hero(
                    tag: "gallery",
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("앨범에서 사진 선택", style: TextStyle(fontSize: 17, color: Colors.black), textAlign: TextAlign.start),
                      )
                  ),
                  onPressed: () async {
                    await takePhoto(ImageSource.gallery);
                    Navigator.pop(context);
                  },

                )
              ],
            ),
          )
        );
      }
    );
  }
  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _im = pickedFile.path;
    });
  }
}