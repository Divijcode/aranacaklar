import 'package:aranacaklar/screens/mainscreen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddBusinessPage extends StatefulWidget {
  const AddBusinessPage({Key? key}) : super(key: key);

  @override
  _AddBusinessPageState createState() => _AddBusinessPageState();
}

class _AddBusinessPageState extends State<AddBusinessPage> {
  String ?_chosenCity;
  String ?_chosenDistrict;
  String ?_chosenCategory;

  TextEditingController _nameController = TextEditingController();

  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  List tags = [];
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagsController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }
  // List<QueryDocumentSnapshot<Map<String, dynamic>>>?data;
  // getData() async{
  //   FirebaseFirestore.instance.collection('allBusinesses').get().then((value){
  //     data= value.docs;
  //     setState(() {
  //
  //     });
  //   });
  // }

  addData() async {
    FirebaseFirestore.instance.collection('allBusinesses').doc(_nameController.text).set({
      'name'  : _nameController.text,
      'district'  :_chosenDistrict,
      'city' :_chosenCity,
      'activeCampaign' :false,
      'address' :_addressController.text,
      'description' :_descriptionController.text,
      'phone' : _phoneController.text,
      'tags' :tags,
      'category' : _chosenCategory
    }).then((value) {

      final snackBar = SnackBar(content: Text('Business added successfully!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
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
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Enter Business Name",
                          hintStyle: TextStyle(
                            fontSize: textDefualtSize,
                            color: textColor,
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
                  height: 45,
                  width: MediaQuery.of(context).size.width,
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
                          value: _chosenCategory,
                          //elevation: 5,
                          style: TextStyle(color: textFieldColor),
                          iconEnabledColor: Colors.black,
                          items: <String>[
                            'Entertainment & Arts',
                            'E-Commerce & Retail',
                            'Food & Drink',
                            'Gaming',
                            'Photography',
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
                            "Select Category",
                            style: TextStyle(
                              fontSize: textDefualtSize,
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Graphik',
                              letterSpacing: -0.3,
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _chosenCategory = value!;
                            });
                          }),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _tagsController,
                        onSubmitted: (value){
                          tags.add(_tagsController.text);
                          _tagsController.clear();
                          setState(() {});
                          },
                        decoration: InputDecoration(
                          hintText: "Enter Tags For This Business",
                          hintStyle: TextStyle(
                            fontSize: textDefualtSize,
                            color: textColor,
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
                if(tags.isNotEmpty)
                  for(int i=0;i<tags.length;i++)
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: darkBlue,
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                              child: Row(
                                children: [
                                  Text(tags[i],style: TextStyle(
                                    color: Colors.white
                                  ),),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(child: Icon(Icons.close,color: Colors.white,size: 15,),onTap: (){
                                    tags.remove(tags[i]);
                                    setState(() {

                                    });
                                  },)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5,)
                        ],
                      )
                    ],
                  ),
                SizedBox(
                  height: 15,
                ),
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
                                  fontSize: textDefualtSize,
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Graphik',
                                  letterSpacing: -0.3,
                                ),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _chosenCity = value!;
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
                                  fontSize: textDefualtSize,
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Graphik',
                                  letterSpacing: -0.3,
                                ),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  _chosenDistrict = value!;
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
                        controller: _addressController,
                        decoration: InputDecoration(
                          hintText: "Enter Detailed Address",
                          hintStyle: TextStyle(
                            fontSize: textDefualtSize,
                            color: textColor,
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
                  height: 45,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: "Enter Business’ Phone Number",
                          hintStyle: TextStyle(
                            fontSize: textDefualtSize,
                            color: textColor,
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
                  height: 180,
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: "Enter Business Description",
                          hintStyle: TextStyle(
                            fontSize: textDefualtSize,
                            color: textColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Graphik',
                            letterSpacing: -0.3,
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: 10,
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
                      ),
                    ),
                    onPressed: () async  {

                      if(_nameController.text.isEmpty||_phoneController.text.isEmpty||_addressController.text.isEmpty||_descriptionController.text.isEmpty||
                      tags.isEmpty||_chosenCategory==null||_chosenCity==null||_chosenDistrict==null)
                        {
                          final snackBar = SnackBar(content: Text('Please enter all the details!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      else{
                        await  addData();

                      }

                    },
                    child: Text(
                      "Submit",
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
