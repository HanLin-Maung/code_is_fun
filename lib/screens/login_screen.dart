import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:mobile_education/api.dart';
import 'package:mobile_education/screens/base_screen.dart';
import 'package:mobile_education/screens/course_screen.dart';
import 'package:mobile_education/screens/featured_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;



  _login() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    var response = await API().login(
      _emailController.text,
      _passwordController.text,
    );
    // if (response.statusCode == 200) {
    if (prefs != null) {
      print('account login');
      print(response.statusCode);
      print(response.body);
      var res = jsonDecode(response.body);
      if (res["success"] == true) {
        isLoading = false;
        await prefs.setString("token", res["accessToken"].toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeaturedScreen(),
          ),
        );
      }
      setState(() {});
    } else {
      // print('failed');
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    setState(() {});
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //           gradient: LinearGradient(begin: Alignment.topCenter, colors: [
  //         Colors.blueGrey.shade900,
  //         Colors.blueGrey.shade700,
  //         Colors.blueGrey.shade400
  //       ])),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           const SizedBox(
  //             height: 80,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(20),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 FadeInUp(
  //                   duration: const Duration(milliseconds: 1000),
  //                   child: const Text(
  //                     "Coding is fun",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 35,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 FadeInUp(
  //                   duration: const Duration(milliseconds: 1300),
  //                   child: const Text(
  //                     "Welcome",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           Expanded(
  //             child: Container(
  //               decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(50),
  //                     topRight: Radius.circular(50),
  //                   )),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(30),
  //                 child: Column(
  //                   children: <Widget>[
  //                     const SizedBox(
  //                       height: 60,
  //                     ),
  //                     FadeInUp(
  //                       duration: const Duration(milliseconds: 1400),
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(10),
  //                             boxShadow: const [
  //                               BoxShadow(
  //                                   color: Color.fromRGBO(28, 21, 18, 0.298),
  //                                   blurRadius: 20,
  //                                   offset: Offset(0, 10))
  //                             ]),
  //                         child: SingleChildScrollView(
  //                           child: Column(
  //                             children: <Widget>[
  //                               Container(
  //                                 padding: const EdgeInsets.all(10),
  //                                 decoration: BoxDecoration(
  //                                   border: Border(
  //                                     bottom: BorderSide(
  //                                         color: Colors.grey.shade200),
  //                                   ),
  //                                 ),
  //                                 child: TextField(
  //                                   controller: _emailController,
  //                                   obscureText: true,
  //                                   decoration: InputDecoration(
  //                                       hintText: 'Email or Phone number',
  //                                       hintStyle:
  //                                           TextStyle(color: Colors.grey),
  //                                       border: InputBorder.none),
  //                                 ),
  //                               ),
  //                               Container(
  //                                 padding: const EdgeInsets.all(10),
  //                                 decoration: BoxDecoration(
  //                                   border: Border(
  //                                     bottom: BorderSide(
  //                                         color: Colors.grey.shade200),
  //                                   ),
  //                                 ),
  //                                 child: TextField(
  //                                   controller: _passwordController,
  //                                   obscureText: true,
  //                                   decoration: const InputDecoration(
  //                                       hintText: 'Password',
  //                                       hintStyle:
  //                                           TextStyle(color: Colors.grey),
  //                                       border: InputBorder.none),
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 30,
  //                     ),
  //                     FadeInUp(
  //                         duration: Duration(milliseconds: 1600),
  //                         child: MaterialButton(
  //                           onPressed: () {
  //                             _login();
  //                             setState(() {});
  //                           },
  //                           height: 40,
  //                           color: Colors.blueGrey[800],
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(50),
  //                           ),
  //                           child: Center(
  //                             child: isLoading
  //                                 ? const SpinKitRing(
  //                                     color: Colors.white,
  //                                     size: 25,
  //                                     lineWidth: 2,
  //                                   )
  //                                 : const Text(
  //                                     "LOGIN",
  //                                     style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                                   ),
  //                           ),
  //                         ))
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Colors.blueGrey.shade900,
            Colors.blueGrey.shade700,
            Colors.blueGrey.shade400
          ],
        )),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top + 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Coding is fun",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: const Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 60,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(28, 21, 18, 0.298),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: 'Email or Phone number',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        hintText: 'Password',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {
                              _login();
                              setState(() {});
                            },
                            height: 40,
                            color: Colors.blueGrey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: isLoading
                                  ? const SpinKitRing(
                                      color: Colors.white,
                                      size: 25,
                                      lineWidth: 2,
                                    )
                                  : const Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
