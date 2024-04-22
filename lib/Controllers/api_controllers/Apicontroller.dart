

import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/country_model.dart';
import '../../View/Screens/get_otp_screen.dart';
import '../../View/Screens/select_country_list.dart';
import '../Api_services.dart';
import 'package:http/http.dart' as http;

class ApiServiceController extends GetxController {
  var countries = <CountryModel>[].obs;
  final ApiService _apiService = ApiService();
  bool isResendingOtp = false;
  String? showError;
  var selectCountries = [].obs;
  var filteredCountries = <CountryModel>[].obs;
  @override
  void onInit() {
    fetchCountries();
    fetchSelectCountries();
    super.onInit();
  }


  void fetchCountries() async {
    try {
      var fetchedCountries = await ApiService.getCountries();
      for (var country in fetchedCountries) {
        countries.add(country);
      }

      print(countries);
    } catch (e) {
      print('Error fetching countries: $e');
    }
  }


  void filterCountries(String query) {
    if (query.isEmpty) {

      filteredCountries.assignAll(countries);
    } else {

      filteredCountries.assignAll(countries.where((country) {

        return country.name!.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }

  Future<void> studentLogin(String telCode, String phone , BuildContext context) async {
    try {
      http.Response response = await _apiService.studentLoginApi(telCode, phone);
      if (response.statusCode == 200) {
        String concatenatedPhone = telCode + phone;

        Get.to(() => GetOtpScreen(phone:concatenatedPhone ,));



      } else {
        print('Failed to call API: ${response.statusCode}');
        Get.snackbar(
          '',
          'Failed to call API: ${response.statusCode}',
          backgroundColor: Colors.grey,
          snackPosition: SnackPosition.BOTTOM,

        );


      }
    } catch (e) {

      print('Exception occurred: $e');
    }
  }

  Future<void> agentLogin(String telCode, String phone , BuildContext context) async {
    try {
      http.Response response = await _apiService.agentLoginApi(telCode, phone);
      if (response.statusCode == 200) {
        String concatenatedPhone = telCode + phone;

        Get.to(() => GetOtpScreen(phone:concatenatedPhone ,));


      } else {

       // print('Failed to call API: ${response.statusCode}');
        Get.snackbar(
          '',
          'Failed to call API: ${response.statusCode}',
          backgroundColor: Colors.grey,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {

      print('Exception occurred: $e');
    }
  }

  Future<void> otpVerification(String Code, String phone , BuildContext context) async {
    try {
      isResendingOtp = true;
      update();
      http.Response response = await _apiService.verfyOtp(Code, phone);


      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        String token = responseBody['data']['access_token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token',token);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelectCountryList()));
      } else {

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Failed to verify OTP. Please try again.'),
        //     backgroundColor: Colors.red,
        //   ),
        // );

        Get.snackbar(
          '',
          'Failed to verify OTP. Please try again.',
          backgroundColor: Colors.grey,
          snackPosition: SnackPosition.BOTTOM,
        );


        print('Failed to call API: ${response.statusCode}');
      }
    } catch (e) {

      print('Exception occurred: $e');
    }finally {
      isResendingOtp = false;
      update();
    }
  }


  Future<void> resendOtp( String phone , BuildContext context) async {
    try {
      http.Response response = await _apiService.resendOtp(phone);
      if (response.statusCode == 200) {




        Get.snackbar(
          '',
          'Otp Successfully Resend.',
          backgroundColor: Colors.grey,
          snackPosition: SnackPosition.BOTTOM,
        );

      } else {



        Get.snackbar(
          '',
          'Failed to call API: ${response.statusCode}',
          backgroundColor: Colors.grey,
          snackPosition: SnackPosition.BOTTOM,
        );

      }
    } catch (e) {

      print('Exception occurred: $e');
    }
  }


  Future<void> fetchSelectCountries() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print('Token not found in SharedPreferences');
      return;
    }


    final response = await http.get(
      Uri.parse('https://studylancer.yuktidea.com/api/select/country'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        selectCountries.addAll(List<Map<String, dynamic>>.from(data['data']['countries']));
      } else {
        print('Failed to fetch countries');
      }
    } else {
      print('Failed to fetch countries');
    }
  }



}
