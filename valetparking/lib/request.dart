import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'customerdetails.dart';

class RequestData extends StatefulWidget {
  RequestData({Key key}) : super(key: key);

  @override
  _RequestDataState createState() => _RequestDataState();
}

class _RequestDataState extends State<RequestData> {
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CusDetails()));
            }),
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
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            data[index]["Parking_Number"] +
                                "\n" +
                                data[index]["Customer"] +
                                "\n" +
                                data[index]["Status"],
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15)),
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
