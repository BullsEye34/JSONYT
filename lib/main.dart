import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MaterialApp(home: App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Map<String, dynamic> list;
  List<dynamic> data = new List<dynamic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNames();
  }

  _getNames() {
    API.getUsers().then((response) {
      var o = response;
      o = o.body.toString();
      setState(() {
        data = json.decode(o);
        //data = list["results"];
      });
      // print(data[1]["genre_ids"][0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data[index]["Name"].toString() +
                    "\t" +
                    data[index]["Type"].toString()),
              );
            }),
      ),
    );
  }
}

class Names {
  int slNo;
  String name;
  String type;

  Names({this.slNo, this.name, this.type});

  Names.fromJson(Map<String, dynamic> json) {
    slNo = json['SlNo'];
    name = json['Name'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SlNo'] = this.slNo;
    data['Name'] = this.name;
    data['Type'] = this.type;
    return data;
  }
}

class API {
  static Future getUsers() {
    var url =
        "https://raw.githubusercontent.com/BullsEye34/JSONYT/master/data.json";
    return http.get(url);
  }
}
