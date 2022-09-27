import "package:flutter/material.dart";
import 'package:valetparking/keyindetails.dart';
import 'package:valetparking/login.dart';
import 'package:valetparking/sharedpref.dart';
import 'http.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Register register;
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  bool _validate = false;
  bool _validate2 = false;
  @override
  Widget build(BuildContext context) {
    return _formLogin();
  }

  Widget _formLogin() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("SignUp Page"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      "https://theground-up.com/images/P/Valet-Sign-GIF.gif",
                      width: 400,
                      height: 500,
                      fit: BoxFit.contain,
                    )),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerUsername,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    errorText: _validate2 ? 'Value Can\'t Be Empty' : null,
                    hintText: 'Enter secure password'),
              ),
            ),
            Container(
              height: 50,
              width: 380,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  if (controllerUsername.text.isEmpty ||
                      controllerPassword.text.isEmpty) {
                    setState(() {
                      controllerUsername.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      controllerPassword.text.isEmpty
                          ? _validate2 = true
                          : _validate2 = false;
                    });
                  } else if (controllerUsername.text != null ||
                      controllerPassword.text != null) {
                        showLoaderDialog(context);
                    Register.connectToAPI(
                            "http://unuttered-mechanism.000webhostapp.com/register.php",
                            controllerUsername.text.toString(),
                            controllerPassword.text.toString())
                        .then((value) async {
                      register = value;
                      setState(() {});
                    });
                    Future.delayed(const Duration(milliseconds: 2000), () async {
                      if (register != null) {
                      print("data status=" + register.status);
                      print("data token=" + register.token);
                      if (register.status == "berjaya") {
                        await SharedPreferencesHelper.setUsername(
                            register.status);
                        await SharedPreferencesHelper.setToken(register.token);
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), //this right here
                                child: Container(
                                  height: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Successfully Register'),
                                        ),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil<
                                                  dynamic>(
                                                context,
                                                MaterialPageRoute<dynamic>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          KeyinDetails(),
                                                ),
                                                (route) =>
                                                    false, //if you want to disable back feature set to false
                                              );
                                            },
                                            child: Center(
                                              child: Text(
                                                "Next",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
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
                      } else {  
                        Navigator.pop(context);              
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), //this right here
                                child: Container(
                                  height: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Register Failed!\n'),
                                        ),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Center(
                                              child: Text(
                                                "Done",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
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
                      }
                    }
                    });
                  }
                  /*Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => KeyinDetails()));*/
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                'Already have account? Login',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
