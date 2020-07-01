import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vandorapp/contactuspage.dart';
import 'loginapiverification.dart';
import 'package:vandorapp/snackbar.dart';

void main() {
  runApp(Main());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue[900], // navigation bar color
    statusBarColor: Colors.blue[900], // status bar color
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print("hello");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dSewa VendorApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  bool hidden = true;

  //@override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  void visibility() {
    setState(() {
      hidden = !hidden;
    });
  }

  final _formKey = GlobalKey<FormState>();
  var sizebox = SizedBox(
    height: 10,
  );

  final snackBar = SnackBar(
      content: Row(
    children: <Widget>[
      CircularProgressIndicator(),
      Text('Please Wait'),
    ],
  ));

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              dsewaLogo(context),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              sizebox,
              TextFormField(
                controller: passwordController,
                obscureText: hidden,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Password';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: hidden
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        visibility();
                      },
                    ),
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              sizebox,
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                minWidth: MediaQuery.of(context).size.width - 10,
                height: 45,
                child: RaisedButton(
                  color: Colors.blue[900],
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PostRequest(emailController.text,passwordController.text,context,false,null);
                      }));
                    }
                  },
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Not registered Yet?"),
                        MaterialButton(
                          splashColor: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          minWidth: 5,
                          height: 5,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ContactUsPage();
                            }));
                          },
                          child: Text("Contact Us"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String validateEmail(String value) {
  Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp emailRegExp = RegExp(emailPattern);

  if (!emailRegExp.hasMatch(value)) {
    return 'Please enter your valid Email';
  } else {
    return null;
  }
}

/*
 * Design for dsewa logo 
 */
Widget dsewaLogo(context) {
  return 
     Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              child: Image.asset('images/logo.png',height: 60,width: 200,)
            )
          ),
        
      ],
    );
}
