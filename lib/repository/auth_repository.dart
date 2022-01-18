import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository{

  login(String username, String password) async{
    var response = await http.post(Uri.parse("https://api-dukcapil.aether.id/api/login"), 
      headers: {
      },
      body: {"username" : username, "password" : password}
    );

    final data = json.decode(response.body);

    if(response.statusCode == 200){
      return data;
    }else{
      throw Exception("Failed Login");
    }
  }

}