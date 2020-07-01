import 'package:flutter/material.dart';
import 'package:vandorapp/slideitem.dart';
import 'displaydatapage.dart';
import 'piechartapicall.dart';
import 'slidedot.dart';
import 'package:vandorapp/main.dart';
import 'loginapiverification.dart';

/*
 * For vendor home page
 */
class Chart extends StatelessWidget {
  var accessToken;
  var vendorName;
  final vendorImage;

  Chart(this.accessToken, this.vendorName, this.vendorImage);
  @override
  Widget build(BuildContext context) {
    return ChartPage(accessToken, vendorName, vendorImage);
  }
}

class ChartPage extends StatefulWidget {
  var accessToken;
  var vendorName;
  final vendorImage;
  ChartPage(this.accessToken, this.vendorName, this.vendorImage);

  @override
  ChartPageState createState() =>
      ChartPageState(this.accessToken, this.vendorName, this.vendorImage);
}

class ChartPageState extends State<ChartPage> {
  var accessToken;
  var vendorName;
  final vendorImage;
  @override
  ChartPageState(this.accessToken, this.vendorName, this.vendorImage);
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<Post> post;
  void initState() {
    super.initState();
    post = fetchPost(this.accessToken);
  }

  onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  final PageController _pageController = PageController(initialPage: 0);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: Icon(
            Icons.verified_user,
            color: Colors.green,
          ),
          title: Text("$vendorName"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                /**
                 * For refresh button
                 */
                logout(false);
              },
            ),
            SizedBox(
              width: 10,
            ),
            PopupMenuButton<int>(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text("Logout"),
                        height: 40,
                      )
                    ],
                onSelected: (value) async {
                  /**
                   * Displaying snackbar while logging out
                   */
                  /**
                   * Logout icon and button
                   */
                  logout(true);
                },
                icon: Stack(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      top: 5.0,
                      left: 1.0,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, image: image(vendorImage)),
                      ),
                    )
                  ],
                ))
          ],
          backgroundColor: Colors.blue[900],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: FutureBuilder<Post>(
                        future: post,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && currentPage == 0) {
                            int order_pickuped =
                                int.parse(snapshot.data.order_pickuped);
                            print(order_pickuped);
                            int order_not_pickuped =
                                int.parse(snapshot.data.order_not_pickuped);
                            return pageView(
                                true,
                                "Created",
                                "Cancelled",
                                order_pickuped,
                                order_not_pickuped,
                                Colors.blue,
                                Colors.red,
                                null,
                                null,
                                null,
                                null,
                                "Order");
                          } else if (snapshot.hasData && currentPage == 1) {
                            int order_return =
                                int.parse(snapshot.data.order_return);
                            int order_Delivered_return =
                                int.parse(snapshot.data.order_Delivered_return);
                            return pageView(
                                true,
                                "In Process",
                                "Returned",
                                order_return,
                                order_Delivered_return,
                                Colors.yellow,
                                Colors.green,
                                null,
                                null,
                                null,
                                null,
                                "Return");
                          } else if (snapshot.hasData && currentPage == 2) {
                            int order_delivered =
                                int.parse(snapshot.data.order_delivered);
                            int order_notdelivered =
                                int.parse(snapshot.data.order_notdelivered);
                            return pageView(
                                true,
                                "In Process",
                                "Delivered",
                                order_delivered,
                                order_notdelivered,
                                Colors.blue,
                                Colors.green,
                                null,
                                null,
                                null,
                                null,
                                "Delivery");
                          } else if (snapshot.hasData && currentPage == 3) {
                            /**
                             * For last slide page
                             */
                            int amtTobeReceived =
                                int.parse(snapshot.data.amtTobeReceived);
                            String lastCoddate = snapshot.data.lastCoddate;
                            int lastCod = int.parse(snapshot.data.lastCod);
                            int pendingAmt =
                                int.parse(snapshot.data.pendingAmt);
                            return pageView(
                                false,
                                "Pending Amount",
                                "Last Cod Amount",
                                pendingAmt,
                                lastCod,
                                null,
                                null,
                                lastCoddate,
                                "Last Cod Date",
                                "Payable Amount",
                                amtTobeReceived,
                                "Accounts");
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < 4; i++)
                          if (i == currentPage)
                            SlideDot(true)
                          else
                            SlideDot(false)
                      ],
                    )
                  ]),
            )
          ],
        ));
  }

  logout(bool val) async {
     /**
      * For refresh button
      */
    if (val==false) {
      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PostRequest(LoginPageState.emailController.text,LoginPageState.passwordController.text,context,false,null);
                      }));
    } else if(val==true){
      /**
        * For logout button
        */
        Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PostRequest(null,null,context,true,accessToken);
                      }));

    }
    // try {
    //   String url = "http://test.dsewa.com.np/api/logout";
    //   Map<String, String> headers = {"Authorization": "Bearer $accessToken"};
    //   http.Response response = await http.post(url, headers: headers);
    //   if (response.statusCode == 200) {
    //     if (val == true) {
    //       /**
    //        * If logout button is pressed then only push...if refresh button is pressed then this code will not execute
    //        */
    //       Navigator.push(context, MaterialPageRoute(builder: (context) {
    //         return Main();
    //       }));
    //     }
    //   } else {
    //     showDialog(
    //         context: context,
    //         child: AlertDialog(
    //           title: Text("Contact Us"),
    //           content:
    //               Text("Problem in our system. Contact us for more details"),
    //         ));
    //   }
    // } catch (e) {
    //   showDialog(
    //       context: context,
    //       child: AlertDialog(
    //           title: Text("No Internet"),
    //           content: val
    //               ? Text(
    //                   "Please check your net connectivity. Internet is required for logging out")
    //               : Text(
    //                   "Please check your net connectivity. Internet is required for refreshing")));
    // }
  }

  DecorationImage image(vendorImage) {
    if (vendorImage == null) {
      return DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("images/l100.png"),
      );
    } else {
      return DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage("http://test.dsewa.com.np/$vendorImage"));
    }
  }

  Widget pageView(
    bool boolVal,
    String status1,
    String status2,
    int result1,
    int result2, [
    Color color1,
    Color color2,
    String result3,
    String status3,
    String status4,
    int result4,
    String pageTitle,
  ]) {
    return PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: onPageChanged,
        itemCount: 4,
        itemBuilder: (context, i) {
          if (boolVal == true) {
            return SlideItem(i, status1, status2, result1, result2, color1,
                color2, pageTitle);
          } else if (boolVal == false) {
            return PllPage(status1, status2, status3, status4, result1, result2,
                result3, result4, pageTitle);
          }
          return CircularProgressIndicator();
        });
  }
}
