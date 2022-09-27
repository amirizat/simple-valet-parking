import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:valetparking/main.dart';
import 'package:valetparking/sharedpref.dart';
import 'http.dart';

class LotData extends StatefulWidget {
  LotData({Key key}) : super(key: key);

  @override
  _LotDataState createState() => _LotDataState();
}

class _LotDataState extends State<LotData> {
  ClearParking clearParking;
  RegisterParking registerParking;
  final _randomNo = TextEditingController();
  bool _validate = false;
  String idInndexs;
  List data;
  var url = "https://unuttered-mechanism.000webhostapp.com/parking.php";

  Future<void> getData() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.json.decode(response.body);
      print(jsonResponse);
      setState(() {
        data = jsonResponse;
      });
    } else {
      print("Request failed with code:${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("PARKING LOT"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                getData();
              }),
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () async {
                await SharedPreferencesHelper.setToken("");
                alertlogout(context);
              }),
        ],
      ),
      body: FutureBuilder(
          future: http.get(url),
          // ignore: missing_return
          builder: (context, snapsot) {
            if (snapsot.connectionState == ConnectionState.done) {
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 100),
                    child: GridView.builder(
                      itemCount: data == null ? 0 : data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          //alignment: Alignment.center,
                          child: new InkResponse(
                            child: Center(
                              child: Text(
                                data[index]["Parking_Number"] +
                                    "\n" +
                                    data[index]["Customer"] +
                                    "\n" +
                                    data[index]["Status"],
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                            onTap: () {
                              idInndexs = (1 + index).toString();
                              print(index);
                              //_randomNo.text="";
                              alert(context);
                            },
                          ),

                          /*decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15)),*/
                        );
                      },
                    ),
                  ));
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

  void alert(BuildContext context) {
    Widget randomNo = TextField(
      controller: _randomNo,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Customer No',
          errorText: _validate ? 'Value Can\'t Be Empty' : null,
          hintText: 'Enter customer no'),
    );
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Clear Parking"),
      onPressed: () {
        print("data no="+_randomNo.toString());
        if (_randomNo.text.isEmpty) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Try Again'),
                  content: Text("Enter customer details"),
                );
              });
        } else if(_randomNo.text != null) {
          ClearParking.connectToAPI(
                  "http://unuttered-mechanism.000webhostapp.com/default.php",
                  idInndexs,_randomNo.text)
              .then((value) async {
            clearParking = value;
            setState(() {});
            if (clearParking != null) {
              if (clearParking.status == "berjaya") {
                showDialog(
                    context: context,
                    builder: (context) {
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
                                      hintText: 'Successfully Clear Parking'),
                                ),
                                SizedBox(
                                  width: 320.0,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Done",
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
      },
    );
    Widget submitButton = FlatButton(
      child: Text("Register Parking"),
      onPressed: () {
        if (_randomNo.text.isEmpty) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Try Again'),
                  content: Text("Enter customer details"),
                );
              });
        } else if (_randomNo.text != null) {
          if (_randomNo.text != null) {
            RegisterParking.connectToAPI(
                    "http://unuttered-mechanism.000webhostapp.com/updateparking.php",
                    idInndexs,
                    _randomNo.text)
                .then((value) async {
              registerParking = value;
              setState(() {});
              if (registerParking != null) {
                if (registerParking.status == "berjaya") {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0)), //this right here
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
                                        hintText:
                                            'Successfully Register Parking'),
                                  ),
                                  SizedBox(
                                    width: 320.0,
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Done",
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
        }
        /*Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CusDetails()));*/
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Details"),
      content: randomNo,
      actions: <Widget>[
        Column(
          children: <Widget>[cancelButton, submitButton],
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}

/*
GridView.builder(
              itemCount: data == null ? 0 : data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(data[index]["Parking_Number"]+"\n"+data[index]["Customer"]+"\n"+data[index]["Status"],style: TextStyle(fontSize:15,color: Colors.white),),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                );
              },
);
*/
