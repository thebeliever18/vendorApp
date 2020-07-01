import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/*
 * For creation of pie-chart
 */
class SlideItem extends StatelessWidget {
  final int indexx;
  int result2;
  int result1;
  String status1;
  String status2;
  Color color1;
  Color color2;
  String pageTitle;
  SlideItem(this.indexx, this.status1, this.status2, this.result1, this.result2,
      this.color1, this.color2,this.pageTitle);
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 130,),
                    Text("$pageTitle",style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: 20,
                      color: color1,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("$status1: $result1")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Container(height: 20, width: 20, color: color2),
                    SizedBox(
                      width: 5,
                    ),
                    Text("$status2: $result2")
                  ],
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
              child:
                  method(status1, status2, result1, result2, color1, color2)),
        )
      ],
    );
  }
}

method(String status1, String status2, int result1, int result2, Color color1,
    Color color2) {
  return charts.PieChart(
    [
      charts.Series(
          domainFn: (label, _) => label.status,
          measureFn: (label, _) => label.result,
          colorFn: (label, _) => label.colour,
          id: 'Chart',
          data: [
            PieChart(status1, result1, color1),
            PieChart(status2, result2, color2),
          ],
          labelAccessorFn: (label, _) => '${label.result.toString()}')
    ],
    defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 80, arcRendererDecorators: [charts.ArcLabelDecorator()]),
  );
}

class PieChart {
  String status;
  int result;
  final charts.Color colour;
  PieChart(this.status, this.result, Color colour)
      : this.colour = charts.Color(
            r: colour.red, g: colour.green, b: colour.blue, a: colour.alpha);
}
