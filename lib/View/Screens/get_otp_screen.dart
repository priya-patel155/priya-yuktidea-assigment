import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:yuktidea_flutter_assemgment/View/Screens/select_country_list.dart';

import '../../Controllers/Theme/app_assets.dart';
import '../../Controllers/Theme/app_color.dart';
import '../../Controllers/api_controllers/Apicontroller.dart';
class GetOtpScreen extends StatefulWidget {
  final String? phone;
  const GetOtpScreen({super.key , this.phone});

  @override
  State<GetOtpScreen> createState() => _GetOtpScreenState();
}

class _GetOtpScreenState extends State<GetOtpScreen> {
  OtpFieldController otpController = OtpFieldController();
  bool _isButtonEnabled = false;
  String? otp;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final apiServiceController = Get.find<ApiServiceController>();
    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomTheme.primaryColor,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(screenHeight * 0.06),
              // here the desired height
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    GestureDetector(
                      onTap: () {
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
                              offset: Offset(0,
                                  3), // changes position of shadow
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
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Center(child: Text('Verify Number', style: TextStyle(
                    color: CustomTheme.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),)),


                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Center(child: Text('Please enter the OTP received to',
                  style: TextStyle(color: CustomTheme.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),)),
                Center(child: Text('verify your number', style: TextStyle(
                    color: CustomTheme.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),)),


                SizedBox(
                  height: screenHeight * 0.08,
                ),
            OTPTextField(
                controller: otpController,
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.underline,
                outlineBorderRadius: 15,

                style: TextStyle(fontSize: 17 , color: Colors.white),
                onChanged: (pin) {
                  print("Changed: " + pin);
                  setState(() {
                    // Enable the button if the OTP length is 5
                    _isButtonEnabled = pin.length == 4;
                    otp=pin;

                  });
                  print('otp==>${otp}');

                },
                onCompleted: (pin) {
                  print("Completed: " + pin);

                }),

                SizedBox(
                  height: screenHeight * 0.2,
                ),


                Center(
                  child: Text('Didn’t receive OTP?',style: TextStyle(color: Color(0xff656366),fontWeight: FontWeight.w400, fontSize: 15),),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      apiServiceController.resendOtp(widget.phone.toString(), context);
                    },
                    child: Container(
                      child: apiServiceController.isResendingOtp
                          ? CircularProgressIndicator() // Show progress indicator while resending OTP
                          : Text(
                        'Resend OTP',
                        style: TextStyle(
                          color: CustomTheme.secondaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height:screenHeight*0.1 ,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      _isButtonEnabled ?apiServiceController.otpVerification(otp.toString() ,widget.phone.toString() , context ) :null;
                      //_isButtonEnabled ?Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectCountryList())):null;
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
                      child: Center(child: Text('Verify',style: TextStyle(color:
                       Color(0xffF9D3B4).withOpacity(0.4)

                      ),)),
                    ),
                  ),
                )

              ],
            ),
          ),


        ));
  }


}