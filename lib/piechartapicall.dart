
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;


/*
 * Api for calling vendor order chart data
 */
Future<Post> fetchPost(accessToken) async {
  Map<String, String> headers = {"Authorization": "Bearer $accessToken"};
  print("header is $headers");
  final response = await http.get('http://test.dsewa.com.np/api/vendor-order-chart',headers:headers);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    var responseJson = json.decode(response.body);
    print(responseJson);
    print(responseJson['data']['AmtTobeReceived']);
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String order_pickuped;
  final String order_not_pickuped;
  final String order_return;
  final String order_Delivered_return;
  final String order_delivered;
  final String order_notdelivered;
  final String lastCoddate;
  final String lastCod;
  final String pendingAmt;
  final String amtTobeReceived;
  Post({
    this.order_pickuped, 
    this.order_not_pickuped, 
    this.order_return, 
    this.order_Delivered_return,
    this.order_delivered,
    this.order_notdelivered,
    this.lastCoddate,
    this.lastCod,
    this.pendingAmt,
    this.amtTobeReceived,
    });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      order_pickuped: json['data']['order_pickuped'].toString(),
      order_not_pickuped: json['data']['order_not_pickuped'].toString(),
      order_return: json['data']['order_return'].toString(),
      order_Delivered_return: json['data']['order_Delivered_return'].toString(),
      order_delivered:json['data']['order_delivered'].toString(),
      order_notdelivered:json['data']['order_notdelivered'].toString(),
      lastCoddate:json['data']['lastCoddate'].toString(),
      lastCod: json['data']['lastCod'].toString(),
      pendingAmt: json['data']['pendingAmt'].toString(),
      amtTobeReceived: json['data']['AmtTobeReceived'].toString(),
    ); 
  }
}