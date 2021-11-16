import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



void main(){
  runApp(MaterialApp(
    home: WebService(),
  ));
}

class WebService  extends StatefulWidget{
  _State createState()=> _State();
}

class _State extends State<WebService>{

  @override
  initState(){
    getAllUser();
    super.initState();
  }


  List users =[];
  bool isloading = false;
  
  Future<String> getAllUser() async{
    setState(()=> this.isloading = true);
    var response = await http.get(Uri.parse('https://api.instantwebtools.net/v1/airlines'));
    setState(()=> users = json.decode(response.body.toString()));
    setState(()=> this.isloading = false);
    return 'get an error';
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Services'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: this.isloading ?Center(
          child: CircularProgressIndicator(),
          heightFactor: 12.0,
          widthFactor: 12.0,
        ) : ListView.builder(
          itemCount: users ==null ? 0: users.length,
          itemBuilder: (jewel,cumilla){
            return Card(
              child: Container(
                height: 200,
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image.network(users[cumilla]['logo']),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(users[cumilla]['name']),
                          Text(users[cumilla]['country']),
                          Text(users[cumilla]['website']),
                          Text(users[cumilla]['slogan']),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }
}