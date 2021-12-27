import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/SignInScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  //회원가입 하는 메소드
  /*void _register() async {
    final AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: idController.text, password: _passwordController.text);
    final FirebaseUser user = result.user;

    if (user == null) {
      final snacBar = SnackBar(
        content: Text("Please try again later"),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          title: Text(
            "회원가입",
            style: TextStyle(
                height: 1.5, fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
        centerTitle: true,
      ),
      body: Id(),
    );
  }

  Widget Id() {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: idController,
                decoration: InputDecoration(
                    labelText: "이메일을 입력해주세요",
                    border: OutlineInputBorder(),
                    hintText: 'E-mail'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "이메일을 입력해주세요";
                  }
                  return null;
                },
              ),
              /*Container(
              margin: const EdgeInsets.only(top: 16),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  //클릭시 검증
                },
                child: Text("이메일 인증"),
              ),
            ),*/
              SizedBox(
                height: 30,
              ),
              TextFormField(
                obscureText: true, // 비밀번호를 적을때 안보이도록
                controller: pwController,
                decoration: InputDecoration(
                    labelText: "회원가입할 비밀번호를 입력해주세요",
                    border: OutlineInputBorder(),
                    hintText: 'password'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "비밀번호를 입력해주세요";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                obscureText: true, // 비밀번호를 적을때 안보이도록
                decoration: InputDecoration(
                    labelText: "비밀번호를 한번 더 입력해주세요",
                    border: OutlineInputBorder(),
                    hintText: 'password'),
                validator: (String value) {
                  if (value != pwController) {
                    return "비밀번호가 일치하지 않습니다.";
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)
                  ),
                  onPressed: () {
                    //_register();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInScreen()));
                  },
                  child: Text('회원가입'),
                ),
              )
            ],
          ),
        ));
  }
}
