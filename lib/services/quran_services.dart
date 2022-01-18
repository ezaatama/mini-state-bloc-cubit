import 'dart:convert';

import 'package:http/http.dart' as http;

class QuranService{
  final baseUrl = "https://api-alquranid.herokuapp.com/surah";

  Future<List<dynamic>> fetchSurah() async{
    try {
      final response = await http.get(Uri.parse(baseUrl));
      return jsonDecode(response.body)["data"] as List<dynamic>;
    } catch (e) {
      return [];
    }
  }
 
}