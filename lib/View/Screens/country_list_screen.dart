import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/Theme/app_assets.dart';
import '../../Controllers/Theme/app_color.dart';
import '../../Controllers/api_controllers/Apicontroller.dart';
import '../../Controllers/api_controllers/terms_controllers.dart';
import 'login_screen.dart';

class CountryListScreen extends StatefulWidget {
  final String? role;
  const CountryListScreen({super.key , this.role});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final ApiServiceController controller = Get.put(ApiServiceController());
    return  Scaffold(
      backgroundColor: CustomTheme.primaryColor,
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
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(ImageUtils.back),
                    ),
                  ),
                ),




              ],
            ),
          )
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 12 , right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Select your country',style: TextStyle(color: CustomTheme.white , fontWeight: FontWeight.w400 , fontSize: 24),)),
            SizedBox(
              height:screenHeight*0.03 ,
            ),


     Container(
             decoration: BoxDecoration(
               color: Color(0xff4B4E4F),
               borderRadius: BorderRadius.circular(10),
             ),
             child: TextField(
               controller: searchController,
               onChanged: (query) {

                 controller.filterCountries(query);
               },
               style: TextStyle(
                 color: Colors.white
               ),
               decoration: InputDecoration(
                 hintText: 'Search',
                 border: InputBorder.none,

                 contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                 hintStyle: TextStyle(color: CustomTheme.white ,fontWeight: FontWeight.w400 , fontSize: 18),
                 prefixIcon:


                 IconButton(
                   icon: Icon(Icons.search , color: CustomTheme.secondaryColor,),
                   onPressed: () {
                     // Add your search logic here
                   },
                 ),
               ),
             ),
           ),

            SizedBox(
              height:screenHeight*0.01 ,
            ),
            Expanded(
              child:Obx(
                    () =>

                    searchController.text.isEmpty ?

                    controller.countries.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount:controller.countries.length,
                  itemBuilder: (context, index) {
                    final country = controller.countries[index];
                    print('country=>${country}');
                    return Column(
                      children: [

                        Container(
                          height: screenHeight*0.006,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.2, 1.0],
                              colors: [
                                Color(0xFF101112).withOpacity(0.2), // 20% position color
                                Color(0xFF212426), // 0% position color
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.to(() => LoginScreen(countrycode: country.telCode,flag:country.flag ,role: widget.role,));


                          },
                          child: Container(
                            padding: EdgeInsets.all(25),


                            child: Row(
                              children: [
                                SvgPicture.network('${country.flag}',fit: BoxFit.cover,height: screenHeight*0.03,),

                                SizedBox(
                                  width: screenWidth*0.05,
                                ),
                                Text('${country.name}'?? '',style: TextStyle(color: CustomTheme.white),),
                                Spacer(),

                                Text('${country.telCode}' ?? '',style: TextStyle(color: CustomTheme.white),) ,
                              ],
                            ),
                          ),
                        ),
                      ],
                    );



                  },
                ) :
                    controller.filteredCountries.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount:controller.filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country =controller.filteredCountries[index];
                        print('country=>${country}');
                        return Column(
                          children: [

                            Container(
                              height: screenHeight*0.006,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.2, 1.0],
                                  colors: [
                                    Color(0xFF101112).withOpacity(0.2), // 20% position color
                                    Color(0xFF212426), // 0% position color
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(() => LoginScreen(countrycode: country.telCode,flag:country.flag ,role: widget.role));

                              },
                              child: Container(
                                padding: EdgeInsets.all(25),


                                child: Row(
                                  children: [
                                    SvgPicture.network('${country.flag}',fit: BoxFit.cover,height: screenHeight*0.03,),

                                    SizedBox(
                                      width: screenWidth*0.05,
                                    ),
                                    Text('${country.name}'?? '',style: TextStyle(color: CustomTheme.white),),
                                    Spacer(),

                                    Text('${country.telCode}' ?? '',style: TextStyle(color: CustomTheme.white),) ,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );



                      },
                    )
              ),)

          ],
        ),
      ),
    );
  }
}
