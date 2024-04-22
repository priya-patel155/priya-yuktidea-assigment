import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/Theme/app_assets.dart';
import '../../Controllers/Theme/app_color.dart';
import '../../Controllers/api_controllers/Apicontroller.dart';
import 'get_otp_screen.dart';
class LoginScreen extends StatefulWidget {
  String? countrycode ;
  String? flag ;
  String? role ;
   LoginScreen({super.key, this.countrycode , this.flag , this.role });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isButtonEnabled = false;
  TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
    final apiServiceController = Get.find<ApiServiceController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.primaryColor,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight*0.06), // here the desired height
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height:screenHeight*0.1 ,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
      
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CustomTheme.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                            ImageUtils.back),
                      ),
                    ),
                  ),
      
      
      
      
                ],
              ),
            )
        ),
      
        body: Padding(
          padding: const EdgeInsets.only(left: 40 , right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height:screenHeight*0.05 ,
              ),
      
              Center(child: Text('Enter phone number',style: TextStyle(color: CustomTheme.white , fontSize: 24 , fontWeight: FontWeight.w400),)),
              SizedBox(
                height:screenHeight*0.02 ,
              ),
              Center(child: Text('Please enter your 10 digit mobile',style: TextStyle(color: CustomTheme.secondaryColor , fontSize: 14 , fontWeight: FontWeight.w400),)),
              Center(child: Text('number to receive OTP',style: TextStyle(color: CustomTheme.secondaryColor , fontSize: 14 , fontWeight: FontWeight.w400),)),
      
              SizedBox(
                height:screenHeight*0.15 ,
              ),
              TextFormField(
                controller: _phoneNumber,
                onChanged: (value) {
                  setState(() {
                    _phoneNumber.text = value;
                    _isButtonEnabled = value.length == 10;
                  });
                },
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                    hintStyle: TextStyle(color: CustomTheme.hintTextColor),
                    border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.network(
                          '${widget.flag.toString()}', // Replace with your flag image path
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 5), // Adjust the spacing as needed
                        Text(
                          '${widget.countrycode.toString()}', // Replace with your country code
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                  ),
      
      
                ),
      
      
              ),
              Container(
                height: screenHeight*0.002,
                  width: screenWidth*0.9,
                decoration: BoxDecoration(
                 color: Color(0xff7D7E80)
                ),
              ),
              SizedBox(
                height:screenHeight*0.3 ,
              ),

              widget.role =='student' ?
      
              Center(
                child: GestureDetector(
                  onTap: (){
                    _isButtonEnabled ?apiServiceController.studentLogin(widget.countrycode.toString() ,_phoneNumber.text , context ) :null;




                  },
                  child: Container(
                    width: screenWidth*0.45,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: CustomTheme.primaryColor,
      
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(child: Text('Get OTP',style: TextStyle(color:
                    _isButtonEnabled ? CustomTheme.secondaryColor : Color(0xffF9D3B4).withOpacity(0.4)
      
                   ),)),
                  ),
                ),
              ) :
              Center(
                child: GestureDetector(
                  onTap: (){
                    _isButtonEnabled ?apiServiceController.agentLogin(widget.countrycode.toString() ,_phoneNumber.text , context ) :null;




                  },
                  child: Container(
                    width: screenWidth*0.45,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: CustomTheme.primaryColor,

                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(child: Text('Get OTP',style: TextStyle(color:
                    _isButtonEnabled ? CustomTheme.secondaryColor : Color(0xffF9D3B4).withOpacity(0.4)

                    ),)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
