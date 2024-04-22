import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/country_model.dart';

class ApiService {

  /// countryList
  static Future<List<CountryModel>> getCountries() async {
    final response = await http.get(Uri.parse('https://studylancer.yuktidea.com/api/countries'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body)['data'];
      print('responsdata :${responseData}');
      return responseData.map((json) => CountryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  /// student login Api

  Future<http.Response> studentLoginApi(String telCode, String phone) async {
    var url = Uri.parse('https://studylancer.yuktidea.com/api/student/login');
    http.Response response = await http.post(
      url,
      body: {
        'tel_code': telCode,
        'phone': phone,
      },
    );
    return response;
  }
/// aent login api

  Future<http.Response> agentLoginApi(String telCode, String phone) async {
    var url = Uri.parse('https://studylancer.yuktidea.com/api/counsellor/login');
    http.Response response = await http.post(
      url,
      body: {
        'tel_code': telCode,
        'phone': phone,
      },
    );
    return response;
  }


  /// verify-otp
  Future<http.Response> verfyOtp(String Code, String phone) async {
    var url = Uri.parse('https://studylancer.yuktidea.com/api/verify-otp');
    http.Response response = await http.post(
      url,
      body: {
        'code': Code,
        'phone': phone,
      },
    );
    return response;
  }


  /// re-send OTp

  Future<http.Response> resendOtp( String phone) async {
    var url = Uri.parse('https://studylancer.yuktidea.com/api/resend-otp');
    http.Response response = await http.post(
      url,
      body: {

        'phone': phone,
      },
    );
    return response;
  }

}
