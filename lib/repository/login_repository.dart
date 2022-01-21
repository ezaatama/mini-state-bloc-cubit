import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginRepository{
  login(String username, String password) async{
    print("attempting login");
    Future.delayed(const Duration(seconds: 2));
    var response = await http.post(Uri.parse("https://api-dukcapil.aether.id/api/login"), 
      headers: {
      },
      body: {"username" : username, "password" : password}
    );

    final data = json.decode(response.body);

    if(response.statusCode == 200){
      print("logged in");
      return data;
    }else{
      throw Exception("Failed Login");
    }
  }

   Future<void> deleteToken() async {
    print("logged out pref clear");
    await Future.delayed(Duration(seconds: 3));
    return;
  }
}