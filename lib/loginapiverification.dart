import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vandorapp/main.dart';
import 'vendorhomepage.dart';

class PostRequest extends StatefulWidget {
  String email;
  String password;
  BuildContext context;
  bool val;
  var accessToken;
  PostRequest(this.email,this.password,this.context,this.val,this.accessToken);
  @override
  State createState() =>
      new PostRequestState(this.email, this.password,this.context,this.val,this.accessToken);
}

class PostRequestState extends State<PostRequest> {
  String email;
  String password;
  BuildContext context;
  bool val;
  var accessToken;
  // bool loading = true;
  PostRequestState(this.email, this.password,this.context,this.val,this.accessToken);
  

  @override
  void initState() {
    super.initState();
    makePostRequest(email, password,context,val,accessToken);
  }

  @override
  Widget build(BuildContext context) {
    print('Hellooooo');
    print(email);
    return Scaffold(
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(width: 10,),
                  Text("Processing...")
                ],
              )
            ],
          )
    );
  }

  makePostRequest([String email, String password,BuildContext context,val,accessToken]) async {
    // set up POST request arguments
    try {
      http.Response response;
      String url;
      if(val==true){
        /**
         * For logout button only
         */
           url = "http://test.dsewa.com.np/api/logout";
           Map<String, String> headers = {"Authorization": "Bearer $accessToken"};
           response = await http.post(url, headers: headers);
           print("success");
      }else if(val==false){
        /**
         * Calling login api
         */
         Map<String, String> body = {"email": email, "password": password};
         url = "http://test.dsewa.com.np/api/login";
         response = await http.post(
          url,
          body: body,
        );
        print("successdouble");
      }
      // check the status code for the result

      int statusCode = response.statusCode;

      /**
       * For logging out
       */
      if(val==true){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Main();
          }));
      }

      if (statusCode == 200 && val==false) {
        var getAccessToken = json.decode(response.body);
        var accessToken = getAccessToken["access_token"];
        var vendorName = getAccessToken["name"];
        final vendorImage = getAccessToken["image"];
        // setState(() {
        //   loading=false;
        // });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Chart(accessToken, vendorName, vendorImage);
        }));
      } else if (val==false){
        Navigator.pop(context);
        showDialog(
            context: context,
            child: AlertDialog(
              title: Text("Not registered"),
              content: Text(
                  "You are not registered as vendor. Contact us or check your email and password"),
            ));
      }
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          child: AlertDialog(
            title: Text("No Internet"),
            content: Text("Net connectivity required"),
          ));
    }
  }
}