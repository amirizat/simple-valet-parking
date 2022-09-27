import 'dart:convert';
import 'package:http/http.dart' as http;

class Register {
  String token;
  String status;
  Register({this.token, this.status});

  factory Register.createdPostResult(Map<String, dynamic> object) {
    return Register(token: object['token'], status: object['status']);
  }

  static Future<Register> connectToAPI(
      String url, String username, String password) async {
    var apiResult = await http.post(url,
        body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body);
    print(jsonObject);
    print(Register.createdPostResult(jsonObject));
    return Register.createdPostResult(jsonObject);
  }
}

class LoGin {
  String username;
  String token;
  String status;
  LoGin({this.username, this.token, this.status});

  factory LoGin.createdPostResult(Map<String, dynamic> object) {
    return LoGin(
        username: object['username'],
        token: object['token'],
        status: object['status']);
  }

  static Future<LoGin> connectToAPI(
      String url, String name, String password) async {
    var apiResult =
        await http.post(url, body: {"username": name, "password": password});
    var jsonObject = json.decode(apiResult.body);
    print(LoGin.createdPostResult(jsonObject));
    return LoGin.createdPostResult(jsonObject);
  }
}

class RegisterCustomer {
  String token;
  String status;
  RegisterCustomer({this.token, this.status});

  factory RegisterCustomer.createdPostResult(Map<String, dynamic> object) {
    return RegisterCustomer(token: object['token'], status: object['status']);
  }

  static Future<RegisterCustomer> connectToAPI(
      String url,
      String idtype,
      String cartype,
      String platenumber,
      String phonenumber,
      String randomnumber) async {
    var apiResult = await http.post(url, body: {
      "id_user": idtype,
      "car_type": cartype,
      "plate_number": platenumber,
      "phone_number": phonenumber,
      "random_number": randomnumber
    });
    var jsonObject = json.decode(apiResult.body);
    print(jsonObject);
    print(RegisterCustomer.createdPostResult(jsonObject));
    return RegisterCustomer.createdPostResult(jsonObject);
  }
}

class GetRandomNo {
  String randomnumber;
  String status;
  GetRandomNo({this.randomnumber,this.status});

  factory GetRandomNo.createdPostResult(Map<String, dynamic> object) {
    return GetRandomNo(
        randomnumber: object['random_number'],
        status: object['status']);
  }

  static Future<GetRandomNo> connectToAPI(
      String url, String iduser) async {
    var apiResult =
        await http.post(url, body: {"id_user": iduser});
    var jsonObject = json.decode(apiResult.body);
    print(GetRandomNo.createdPostResult(jsonObject));
    return GetRandomNo.createdPostResult(jsonObject);
  }
}

class RegisterParking {
  String status;
  RegisterParking({this.status});

  factory RegisterParking.createdPostResult(Map<String, dynamic> object) {
    return RegisterParking(
        status: object['status']);
  }

  static Future<RegisterParking> connectToAPI(
      String url, String id,String username) async {
    var apiResult =
        await http.post(url, body: {"id": id,"username": username});
    var jsonObject = json.decode(apiResult.body);
    print(RegisterParking.createdPostResult(jsonObject));
    return RegisterParking.createdPostResult(jsonObject);
  }
}

class ClearParking {
  String status;
  String radNo;
  ClearParking({this.status,this.radNo});

  factory ClearParking.createdPostResult(Map<String, dynamic> object) {
    return ClearParking(
        status: object['status'],radNo: object['random_no']);
  }

  static Future<ClearParking> connectToAPI(
      String url, String id,String radno) async {
    var apiResult =
        await http.post(url, body: {"id": id,"random_number":radno});
    var jsonObject = json.decode(apiResult.body);
    print(ClearParking.createdPostResult(jsonObject));
    return ClearParking.createdPostResult(jsonObject);
  }
}
