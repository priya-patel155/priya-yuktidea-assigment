import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/Theme/app_assets.dart';
import '../../Controllers/Theme/app_color.dart';
import '../../Controllers/api_controllers/Apicontroller.dart';
class SelectCountryList extends StatefulWidget {
  const SelectCountryList({super.key});

  @override
  State<SelectCountryList> createState() => _SelectCountryListState();
}

class _SelectCountryListState extends State<SelectCountryList> {
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
                        Get.back();

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
            padding: const EdgeInsets.only(left: 20 , right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Center(child: Text('Select Country', style: TextStyle(
                    color: CustomTheme.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),)),

                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Center(child: Text('Please select the country where',
                  style: TextStyle(color: CustomTheme.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),)),
                Center(child: Text('you want to study', style: TextStyle(
                    color: CustomTheme.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),)),
                SizedBox(
                  height: screenHeight * 0.05,
                ),

                Container(
                  height:  screenHeight * 0.5,
                //  decoration: BoxDecoration(color: Colors.red),
                  child: Obx(
                        () => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.0,

                      ),
                      itemCount: apiServiceController.selectCountries.length,
                      itemBuilder: (context, index) {
                        final country = apiServiceController.selectCountries[index];
                        return _buildCountryItem(country);
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),

        ));
  }
  Widget _buildCountryItem(country) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return InkWell(
      onTap: () {


      },
      child:   Container(
        child: Column(
          children: [
            Container(
              height:screenHeight*0.18 ,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),



                  image: DecorationImage(
                      image: NetworkImage(
                          country['image']
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(height: 10.0),
                  Text(
                    country['name'],
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                  ),
          ],
        ),
      )


    );
  }
}
