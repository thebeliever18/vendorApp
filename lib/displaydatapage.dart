import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PllPage extends StatefulWidget {
  String status1, status2, status3, status4, result3, pageTitle;
  int result1, result2, result4;

  PllPage(this.status1, this.status2, this.status3, this.status4, this.result1,
      this.result2, this.result3, this.result4, this.pageTitle);
  @override
  PllPageState createState() => PllPageState(
      this.status1,
      this.status2,
      this.status3,
      this.status4,
      this.result1,
      this.result2,
      this.result3,
      this.result4,
      this.pageTitle);
}

class PllPageState extends State<PllPage> {
  String status1, status2, status3, status4, result3, pageTitle;
  int result1, result2, result4;
  PllPageState(this.status1, this.status2, this.status3, this.status4,
      this.result1, this.result2, this.result3, this.result4, this.pageTitle);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                child: Text(
                  "$pageTitle",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            /**
             * Payable amount
             */
            container(status4, result4.toString()),
            
            SizedBox(
              height: 10,
            ),
            /**
             * Pending amount
             */
            container(status1, result1.toString()),
            SizedBox(
              height: 10,
            ),
            /**
             * Last Cod Date
             */
            container(status3, result3),
            
            SizedBox(
              height: 10,
            ),
            /**
             * Last Cod Amount
             */
            container(status2, result2.toString()),
            SizedBox(
              height: 10,
            ),
          ]),
    );
  }

  Widget container(String status, String amount) {
    return Expanded(
      flex: 1,
      child: Container(
        height: (MediaQuery.of(context).size.height / 8),
        width: MediaQuery.of(context).size.width - 150,
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          elevation: 5.0,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "$amount",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              Text(
                status,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
