import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:vandorapp/main.dart';

/**
 * For contact us page
 */
class ContactUsPage extends StatefulWidget{
  @override
   ContactUsPageState createState() => ContactUsPageState();
}

class ContactUsPageState extends State<ContactUsPage>{
  @override
  bool isLoading = true;
  void pageFinishedLoading(WebViewController){
  setState(() {
      isLoading = false;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: (){
            Navigator.pop(context,MaterialPageRoute(
              builder: (context){
                return Main();
              }
            ));
          },
        ),
        title: Text("Dsewa Webpage"),
        
      ),
      body: Column(
        children: <Widget>[
          if (isLoading == true)
            LinearProgressIndicator(),
          
          Expanded(
            child: WebView(
            onPageFinished: pageFinishedLoading,
            /**
             * Calling dsewa page
             */
            initialUrl: 'https://www.dsewa.com.np/',
            javascriptMode: JavascriptMode.unrestricted,
        ),
          ),
        ],
      )
    );
 
}
}


  
