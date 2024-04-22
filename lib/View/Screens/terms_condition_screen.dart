import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:yuktidea_flutter_assemgment/Controllers/Theme/app_assets.dart';
import 'package:yuktidea_flutter_assemgment/Controllers/Theme/app_color.dart';
import '';
import '../../Controllers/api_controllers/terms_controllers.dart';


class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final TermsConditionController controller = Get.put(TermsConditionController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.primaryColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight*0.06), // here the desired height
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                        child: SvgPicture.asset(ImageUtils.cross),
                      ),
                    ),
                  ),
      
      
      
      
                ],
              ),
            )
        ),
      
        body:  Obx(() {
          if (controller.termsAndConditions.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
      
      
                      SvgPicture.asset(ImageUtils.document),
                      SizedBox(
                        width:screenWidth*0.04 ,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.title.value,
                            style: TextStyle(color: CustomTheme.secondaryColor, fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          SizedBox(
                            height:screenHeight*0.01 ,
                          ),
                          Text(
                            'Update ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.updateDate.value))}',
                            style: const TextStyle(color: Color(0xff7D7E80), fontWeight: FontWeight.bold),
                          ),
      
      
                        ],
                      )
      
      
                    ],
                  ),
      
                  SizedBox(
                    height:screenHeight*0.04 ,
                  ),
      
      
      
                  ...controller.termsAndConditions
                ],
              ),
            );
          }
        }),
      
      
      ),
    );
  }
}
