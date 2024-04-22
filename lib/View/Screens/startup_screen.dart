import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:yuktidea_flutter_assemgment/Controllers/Theme/app_assets.dart';
import 'package:yuktidea_flutter_assemgment/Controllers/Theme/app_color.dart';
import 'package:yuktidea_flutter_assemgment/View/Screens/terms_condition_screen.dart';

import 'country_list_screen.dart';
class StartUpScreen extends StatefulWidget {
  const StartUpScreen({super.key});

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child:  Scaffold(
          body: Stack(
            children: [
              Container(

                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageUtils.startup),
                        fit: BoxFit.cover
                    )
                ),





              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: screenHeight*0.4,

                  decoration: const BoxDecoration(
                    color: CustomTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), // Half of the container's width and height to create a circle
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height:screenHeight*0.03 ,
                      ),
                      Text('Welcome to Study Lancer',style: TextStyle(color: CustomTheme.white , fontSize: 24 , fontWeight: FontWeight.w600),),
                      SizedBox(
                        height:screenHeight*0.01 ,
                      ),
                      Text('Please select your role to get registered',style: TextStyle(color: CustomTheme.white , fontSize: 15 , fontWeight: FontWeight.w400),),
                      SizedBox(
                        height:screenHeight*0.04 ,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20 , right: 20),
                        child: Row(
                          children: [

                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryListScreen(role: 'student',)));

                                      Get.to(() => CountryListScreen(role: 'student'));
                                    },
                                    child: Container(
                                     height:screenHeight*0.15 ,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: CustomTheme.primaryColor.withOpacity(0.8) , width: 5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        image: DecorationImage(
                                          image: AssetImage(
                                            ImageUtils.student
                                          ),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:screenHeight*0.01 ,
                                  ),
                                  Text('Student',style: TextStyle(color: CustomTheme.white , fontWeight: FontWeight.w600 , fontSize: 14),)
                                ],
                              ),
                            ) ,
                            SizedBox(
                              width:screenWidth*0.05 ,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryListScreen(role: 'agent',)));
                                      Get.to(() => CountryListScreen(role: 'agent'));

                                    },
                                    child: Container(
                                      height:screenHeight*0.15 ,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: CustomTheme.primaryColor.withOpacity(0.8) , width: 5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        image: DecorationImage(
                                          image: AssetImage(
                                            ImageUtils.agent
                                          ),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:screenHeight*0.01 ,
                                  ),
                                  Text('Agent',style: TextStyle(color: CustomTheme.white , fontWeight: FontWeight.w600 , fontSize: 14),)
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(
                        height:screenHeight*0.03 ,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsConditions()));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'By continuing you agree to our ',
                            style: TextStyle(color: CustomTheme.white , fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(color:CustomTheme.secondaryColor  , fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      )


                    ],
                  ),
                ),
              )

            ],
          ),
        )


    );
  }
}
