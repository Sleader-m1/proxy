import 'package:first/screens/home_screen.dart';
import 'package:first/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:first/model/locale_storage.dart';

class VerifScreen extends StatefulWidget {
  const VerifScreen({Key? key}) : super(key: key);

  @override
  _VerifScreenState createState() => _VerifScreenState();
}

class _VerifScreenState extends State<VerifScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController verificationController = new TextEditingController();

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //verification code field
    final verificationField = TextFormField(
        autofocus: false,
        controller: verificationController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Verification Code");
          }
          // reg expression for email validation
          if (!RegExp("^[0-9]")
              .hasMatch(value)) {
            return ("Please Enter a valid code");
          }
          return null;
        },
        onSaved: (value) {
          verificationController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Verification code",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(verificationController.text );
          },
          child: Text(
            "Confirm",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                    verificationField,
                    SizedBox(height: 15),
                    loginButton
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String verificationCode) async {
    if (_formKey.currentState!.validate()) {
      var url = 'http://95.164.17.135:8000/api/ver_code';
      var data = {
        "code": verificationCode,
      }; // Пример данных в формате JSON

      var token = await Storage.getToken();

      var response = await http.post(Uri.parse(url), body: data, headers: {'Auth' : token});

      if (response.statusCode == 200) {
        print('Account verified');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen()));
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }
}