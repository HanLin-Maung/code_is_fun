import 'package:flutter/material.dart';
import 'package:mobile_education/screens/login_screen.dart';
import 'package:mobile_education/screens/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //     height: double.infinity,
    //     width: double.infinity,
    //     decoration:  BoxDecoration(
    //       gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         colors: [
    //           // Color.fromARGB(255, 43, 42, 48),
    //           // Color.fromARGB(255, 85, 4, 206),
    //           // Color.fromARGB(255, 142, 138, 149)
    //           Colors.blueGrey.shade900,
    //           Colors.blueGrey.shade700,
    //           Colors.blueGrey.shade400
    //         ]
    //       )
    //     ),
    //     child: Center(
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Image.asset(
    //             'assets/images/code.png',
    //             width: 300,
    //           ),
    //           const SizedBox(height: 50,),
    //           Text(
    //             'Welcome To Coding is Fun',
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 20,
                  
    //             ),
    //             textAlign: TextAlign.center,
    //           ),
              
    //         ],
    //         // children: [
    //         //   Padding(
    //         //     padding: EdgeInsets.only(top: 200.0),
    //         //     child: Image(image: AssetImage('assets/images/code.png'),
    //         //     ),
    //         //   ),
    //         //   SizedBox(height: 100,),
    //         //   Text(
    //         //     'Welcome Back',
    //         //     style: TextStyle(
    //         //       fontSize: 30,
    //         //       color: Colors.white
    //         //     ),
    //         //   ),
    //         //   SizedBox(height: 30,),
              
    //         // ]
    //         ),
    //             ),
    //     ),
    // );
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 52, 71, 81),
              Color.fromARGB(255, 30, 39, 44),
        ])),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Image(image: AssetImage('assets/images/code.png')),
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            'CodingIS Fun',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ]
        ),
      ),
    );
  }
}