import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valetparking/main.dart';
import 'package:valetparking/request.dart';
import 'package:valetparking/sharedpref.dart';
import 'http.dart';

class CusDetails extends StatefulWidget {
  CusDetails({Key key}) : super(key: key);

  @override
  _CusDetailsState createState() => _CusDetailsState();
}

class _CusDetailsState extends State<CusDetails> {
  GetRandomNo getRandomNo;
  String username;
  @override
  Widget build(BuildContext context) {
    return _cusDetail();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getStringValuesSF().then((value) {
        username = value;
      });
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      GetRandomNo.connectToAPI(
              "http://unuttered-mechanism.000webhostapp.com/customer.php",
              username)
          .then((value) async {
        getRandomNo = value;
        setState(() {});
      });
    });
  }

  Widget _cusDetail() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Customer Details Page"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () async {
                await SharedPreferencesHelper.setToken("");
                alertlogout(context);
              }),
        ],
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 2000), () {
            GetRandomNo.connectToAPI(
                "http://unuttered-mechanism.000webhostapp.com/customer.php",
                username);
          }),
          // ignore: missing_return
          builder: (context, snapsot) {
            if (snapsot.connectionState == ConnectionState.done) {
              //print(getRandomNo.randomnumber);
              //print(username);
              return Center(
                child: Card(
                  elevation: 50,
                  child: SizedBox(
                    width: 350,
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 20),
                          child: Text(
                            "Valet Parking Details",
                            style: new TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 65, bottom: 40),
                          child: Text(
                            getRandomNo.randomnumber.toString() ?? "",
                            style: TextStyle(fontSize: 20),
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
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => RequestData()));
                                },
                                child: Text("View Parking"))),
                      ]),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
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

/*Center(
        child: Card(
          elevation: 50,
          child: SizedBox(
            width: 350,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 20),
                  child: Text(
                    "Valet Parking Details",
                    style: new TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 65, bottom: 40),
                  child: Text(
                    getRandomNo.randomnumber.toString() == null ? 0 : ("tiada data"),
                    style: TextStyle(fontSize: 20),
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
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => RequestData()));
                        },
                        child: Text("View Parking"))),
              ]),
            ),
          ),
        ),
      ),
*/
