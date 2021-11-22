import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_app/model/usermodel.dart';
import 'package:chat_app/Authenticate/Methods.dart';
import 'package:flutter/material.dart';
//import 'package:stream_chat_flutter/stream_chat_flutter.dart';


import '../Screens/HomeScreen.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _idUrl = TextEditingController();
 // final TextEditingController _email = TextEditingController();
  //final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 0.5,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Create Account to Continue!",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: customTextfield(size, "Enter url", Icons.account_box, _idUrl),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  customButton(size),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () async {
        if (_idUrl.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
       firebaseAccountCreator();
        } else {
          print("Please enter Fields");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue,
          ),
          alignment: Alignment.center,
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget customTextfield(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
   getData(String urlq) async {
    print('get data function started ===');
    // String url =url
    //     "https://cero-travancode.herokuapp.com/users/6177bb898f45e5001687a543";
    http.Response response = await http.post(Uri.parse(urlq));
    print(response.body);
    var res = jsonDecode(response.body);
      userModel = UserModel.fromJson(res);
    print('get data response value   {$res}');
    return res;
    // String url2 =
    //     "https://cero-travancode.herokuapp.com/users/6177a2a9761cc3001671bbd0";
    // http.Response response2 = await http.post(Uri.parse(url2));
    // print(response2.body);
    // var res2 = jsonDecode(response2.body);
    //  userModel2 = UserModel.fromJson(res2);
  }

  void firebaseAccountCreator() async{
    await getData(_idUrl.text);
    createAccount(userModel.name.toString(), userModel.email.toString(), userModel.password.toString())
        .then((user) {
      if (user != null) {
        setState(() {
          isLoading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
        print("Account Created Sucessfull");
      } else {
        print("Login Failed");
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}


