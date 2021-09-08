import 'package:aranacaklar/customTile.dart';
import 'package:aranacaklar/screens/loginpage.dart';
import 'package:aranacaklar/screens/addbusiness.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MainPage extends StatefulWidget {
  MainPage({this.docs});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> ?docs;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _chosenCity;
  String? _chosenDistrict;
  bool _isVisible = false;

  _makingPhoneCall(String num) async {
    const String url = 'tel:8931964762';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'a',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 42,
                  fontFamily: 'Arista Pro',
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Login Text Clicked');
                   final user = FirebaseAuth.instance.currentUser;
                   if(user==null)
                     Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                   else
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context) => AddBusinessPage()));
                  }),
            TextSpan(
              text: 'ranacaklar',
              style: TextStyle(
                fontFamily: 'Arista Pro',
                fontSize: 42,
                color: darkBlue,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.3,
              ),
            ),
          ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      decoration: BoxDecoration(
                        color: textFieldColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: textColor,
                              ),
                              focusColor: Colors.white,
                              value: _chosenCity,
                              //elevation: 5,
                              style: TextStyle(color: textFieldColor),
                              iconEnabledColor: Colors.black,
                              items: <String>[
                                'Kanpur',
                                'Allahabad',
                                'Agra',
                                'Meerut',
                                'Varanasi',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Select City",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Graphik',
                                  letterSpacing: -0.3,
                                ),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _chosenCity = value;
                                });
                              }),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      decoration: BoxDecoration(
                        color: textFieldColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: textColor,
                              ),
                              focusColor: Colors.white,
                              value: _chosenDistrict,
                              //elevation: 5,
                              style: TextStyle(color: textFieldColor),
                              iconEnabledColor: Colors.black,
                              items: <String>[
                                'Kanpur',
                                'Allahabad',
                                'Agra',
                                'Meerut',
                                'Varanasi',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Select District",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Graphik',
                                  letterSpacing: -0.3,
                                ),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _chosenDistrict = value;
                                });
                              }),
                        ),
                      ),
                    )
                  ],
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        // controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Write Tags",
                          hintStyle: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Graphik',
                            letterSpacing: -0.3,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    color: listContainerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTile(
                          isVisible: false,
                          shopName: "Avocado Hub",
                          shopCategoryName: "Food & Drink",
                          isFire: true,
                          phoneNo: "8931964762",
                          address: "Opera, Ulus, ANKARA",
                          desc:
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        ),
                        CustomTile(
                          isVisible: false,
                          shopName: "Snap Masters",
                          shopCategoryName: "Photography",
                          isFire: true,
                          phoneNo: "8931964762",
                          address: "Opera, Ulus, ANKARA",
                          desc:
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        ),
                        CustomTile(
                          isVisible: false,
                          shopName: "Avocado Hub",
                          shopCategoryName: "Food & Drink",
                          isFire: true,
                          phoneNo: "8931964762",
                          address: "Opera, Ulus, ANKARA",
                          desc:
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        ),
                        CustomTile(
                          isVisible: false,
                          shopName: "Snap Masters",
                          shopCategoryName: "Photography",
                          isFire: false,
                          phoneNo: "8931964762",
                          address: "Opera, Ulus, ANKARA",
                          desc:
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        ),
                        CustomTile(
                          isVisible: false,
                          shopName: "Avocado Hub",
                          shopCategoryName: "Food & Drink",
                          isFire: false,
                          phoneNo: "8931964762",
                          address: "Opera, Ulus, ANKARA",
                          desc:
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        ),
                        CustomTile(
                          isVisible: false,
                          shopName: "Snap Masters",
                          shopCategoryName: "Photography",
                          isFire: false,
                          phoneNo: "8931964762",
                          address: "Opera, Ulus, ANKARA",
                          desc:
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        ),
                        CustomTile(
                          isVisible: false,
                          shopName: "Snap Masters",
                          shopCategoryName: "Photography",
                          isFire: false,
                          phoneNo: "8931964762",
                          address: "Opera, Ulus, ANKARA",
                          desc:
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        ),
                        CustomTile(
                          isVisible: false,
                          shopName: "Avocado Hub",
                          shopCategoryName: "Food & Drink",
                          isFire: false,
                          phoneNo: "8931964762",
                          address: "Opera, Ulus, ANKARA",
                          desc:
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        ),
                        CustomTile(
                          isVisible: false,
                          shopName: "Snap Masters",
                          shopCategoryName: "Photography",
                          isFire: false,
                          phoneNo: "8931964762",
                          address: "Opera, Ulus, ANKARA",
                          desc:
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "*Placeholder text for business registration call to action*",
                  style: TextStyle(
                    letterSpacing: -0.3,
                    fontSize: textDefualtSize,
                    color: listTitleColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Graphik',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  // height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: darkBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      onPressed: () => launch("tel:918931964762"),
                      child: ListTile(
                        minLeadingWidth: 0,
                        horizontalTitleGap: 8,
                        title: Text(
                          "Call Aranacaklar",
                          style: TextStyle(
                            fontSize: textDefualtSize + 3,
                            color: listContainerColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Graphik',
                            letterSpacing: -0.3,
                          ),
                        ),
                        leading: Icon(
                          Icons.phone_outlined,
                          color: Colors.white,
                        ),
                        trailing: Stack(
                          children: [
                            Positioned(
                              right: 8,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white.withOpacity(0.7),
                                size: 20,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
