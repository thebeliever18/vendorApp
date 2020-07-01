import 'package:flutter/material.dart';

/*
 * For snackbar
 */
snackBarShow(scaffoldKey){
  return scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Row(
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(width: 10,),
        Text('Processing...'),
      ],
    ),
    duration: Duration(seconds: 3),
  ));
}
