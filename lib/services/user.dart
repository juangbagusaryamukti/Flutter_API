import 'dart:convert';
import 'package:movie_app/models/response_data_map.dart';
import 'package:movie_app/models/user_login.dart';
import 'package:movie_app/services/url.dart' as url;
import 'package:http/http.dart' as http;

class UserService {
  Future<ResponseDataMap> registerUser(Map<String, dynamic> data) async {
    var uri = Uri.parse(url.BaseUrl + "/register_admin");
    var register = await http.post(uri, body: data);

    if (register.statusCode == 201) {
      var responseData = json.decode(register.body);
      if (responseData["status"] == true) {
        return ResponseDataMap(
          status: true,
          message: "Sukses menambah user",
          data: responseData,
        );
      } else {
        var message = '';
        for (String key in responseData["message"].keys) {
          message += responseData["message"][key][0].toString() + '\n';
        }
        return ResponseDataMap(status: false, message: message);
      }
    } else {
      return ResponseDataMap(
        status: false,
        message: "Gagal menambah user dengan code error"
      );
    }
  }

  Future<ResponseDataMap> loginUser(Map<String, String> data) async {
    var uri = Uri.parse(url.BaseUrl + "/login");
    var response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData["status"] == true) {
        UserLogin userLogin = UserLogin(
          status: responseData["status"],
          token: responseData["authorisation"]["token"],
          message: responseData["message"],
          id: responseData["data"]["id"],
          name: responseData["data"]["name"],
          email: responseData["data"]["email"],
          role: responseData["data"]["role"],
        );
        await userLogin.prefs();

        return ResponseDataMap(
          status: true,
          message: "Sukses login user",
          data: responseData,
        );
      } else {
        return ResponseDataMap(status: false, message: "Email dan password salah");
      }
    } else {
      return ResponseDataMap(
        status: false,
        message: "Gagal login user dengan code error ${response.statusCode}",
      );
    }
  }
}
