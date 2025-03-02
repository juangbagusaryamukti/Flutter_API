import 'dart:convert';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/response_data_list.dart';
import 'package:movie_app/models/user_login.dart';
import 'package:movie_app/services/url.dart' as url;
import 'package:http/http.dart' as http;

class MovieService {
  Future getMovie() async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();
    if (user.status == false) {
      ResponseDataList response = ResponseDataList(
          status: false, message: 'anda belum login / token invalid');
      return response;
    }
    var uri = Uri.parse(url.BaseUrl + "/belajar_laravel/get_movie");
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
    };
    var getMovie = await http.get(uri, headers: headers);

    if (getMovie.statusCode == 200) {
      var data = json.decode(getMovie.body);
      if (data["status"] == true) {
        List movie = data["data"].map((r) => MovieModel.fromJson(r)).toList();
        ResponseDataList response = ResponseDataList(
            status: true, message: 'success load data', data: movie);
        return response;
      } else {
        ResponseDataList response =
            ResponseDataList(status: false, message: 'Failed load data');
        return response;
      }
    } else {
      ResponseDataList response = ResponseDataList(
          status: false,
          message: "gagal load movie dengan code error ${getMovie.statusCode}");
      return response;
    }
  }
}
