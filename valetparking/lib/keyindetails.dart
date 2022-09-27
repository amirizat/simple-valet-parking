import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valetparking/customerdetails.dart';
import 'package:valetparking/http.dart';
import 'dart:math';
import 'package:valetparking/main.dart';
import 'package:valetparking/sharedpref.dart';

class KeyinDetails extends StatefulWidget {
  KeyinDetails({Key key}) : super(key: key);
  @override
  _KeyinDetailsState createState() => _KeyinDetailsState();
}

class _KeyinDetailsState extends State<KeyinDetails> {
  RegisterCustomer registerCustomer;
  String username = "";
  final _cartype = TextEditingController();
  final _plateNumber = TextEditingController();
  final _phoneNumber = TextEditingController();

  bool _validate = false;
  bool _validate2 = false;
  bool _validate3 = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      getStringValuesSF().then((value) {
        username = value;
        print(username);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _formKeyin();
  }

  Widget _formKeyin() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Details Page"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () async {
                await SharedPreferencesHelper.setToken("");
                await SharedPreferencesHelper.setUsername("");
                alertlogout(context);
              }),
        ],
      ),
      body: Center(
        child: Card(
          elevation: 50,
          child: SizedBox(
            width: 350,
            height: 550,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Fill in this form"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 0),
                    child: TextField(
                      controller: _cartype,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Type of Car',
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: 'Enter type of Car'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: _plateNumber,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Plate Number',
                          errorText:
                              _validate2 ? 'Value Can\'t Be Empty' : null,
                          hintText: 'Make sure enter correct plate number'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 10),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: _phoneNumber,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                          errorText:
                              _validate3 ? 'Value Can\'t Be Empty' : null,
                          hintText: 'Make sure enter correct phone number'),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 280,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: FlatButton(
                      onPressed: () {
                        if (_cartype.text.isEmpty ||
                            _phoneNumber.text.isEmpty ||
                            _plateNumber.text.isEmpty) {
                          setState(() {
                            _cartype.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                            _plateNumber.text.isEmpty
                                ? _validate2 = true
                                : _validate2 = false;
                            _phoneNumber.text.isEmpty
                                ? _validate3 = true
                                : _validate3 = false;
                          });
                        } else {
                          alert(context);
                        }
                      },
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 20),
                    child: Container(
                      height: 50,
                      width: 280,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: FlatButton(
                        onPressed: () {
                          if (username == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Try Again'),
                                    content:
                                        Text("You not register your parking"),
                                  );
                                });
                          } else {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => CusDetails(),
                              ),
                              (route) =>
                                  false, //if you want to disable back feature set to false
                            );
                          }
                        },
                        child: Text(
                          'VIEW PARKING',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int generateNumber() {
    Random random = new Random();
    int randomNumber = random.nextInt(40000) + 10000;
    return randomNumber;
  }

  void alert(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget submitButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        if (_cartype.text != null ||
            _plateNumber.text != null ||
            _phoneNumber.text != null) {
          RegisterCustomer.connectToAPI(
                  "http://unuttered-mechanism.000webhostapp.com/addcustomer.php",
                  username,
                  _cartype.text,
                  _plateNumber.text,
                  _phoneNumber.text,
                  generateNumber().toString())
              .then((value) async {
            registerCustomer = value;
            setState(() {});
            if (registerCustomer != null) {
              if (registerCustomer.status == "berjaya") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Successfully Register'),
                                ),
                                SizedBox(
                                  width: 320.0,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil<dynamic>(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) =>
                                              CusDetails(),
                                        ),
                                        (route) =>
                                            false, //if you want to disable back feature set to false
                                      );
                                    },
                                    child: Text(
                                      "Next Page",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: const Color(0xFF1BC0C5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (registerCustomer.status == 'user already have') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Try Again'),
                        content: Text("User Already Haved"),
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Try Again'),
                        content: Text("Something wrong somewhere"),
                      );
                    });
              }
            }
          });
        }
        /*Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CusDetails()));*/
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Details"),
      content: Text("Confirm your details.\n\nType of Car = " +
          _cartype.text +
          "\n" +
          "Plate number=" +
          _plateNumber.text +
          "\n" +
          "Phone Number=" +
          _phoneNumber.text),
      actions: <Widget>[cancelButton, submitButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void alertlogout(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget submitButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Details"),
      content: Text("Are You Sure To Logout?"),
      actions: <Widget>[cancelButton, submitButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('username');
    return stringValue;
  }
}
