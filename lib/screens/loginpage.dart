import 'package:aranacaklar/screens/addbusiness.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _login() async {

    FirebaseFirestore.instance.collection('adminEmails').doc('mails').get().then((value) {
      if(value.data()!['mails'].contains(loginController.text)){

        FirebaseFirestore.instance.collection('loggedInUsers').doc('users').get().then((data) {

          List users = data.data()!['users'];

          if(users.contains(loginController.text)) {
            FirebaseAuth.instance.signInWithEmailAndPassword(
                email: loginController.text, password: passwordController.text)
                .then((value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBusinessPage()));
            });
          }else{
            FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: loginController.text, password: passwordController.text)
                .then((value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBusinessPage()));
            });
          }
        });

      }
      else{

        final snackBar = SnackBar(content: Text('You\'re not an admin!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }




    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'aranacaklar',
                  style: TextStyle(
                    fontSize: 42,
                    color: darkBlue,
                    fontFamily: 'Arista Pro',
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextField(
                      controller: loginController,
                      decoration: InputDecoration(
                        hintText: "User ID",
                        hintStyle: TextStyle(
                          fontSize: textDefualtSize + 2,
                          color: textColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Graphik',
                          letterSpacing: -0.3,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person_outline,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: textDefualtSize + 2,
                          color: textColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Graphik',
                          letterSpacing: -0.3,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    onPressed: () {

                      _login();

                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: textDefualtSize + 2,
                        color: listContainerColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Graphik',
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
