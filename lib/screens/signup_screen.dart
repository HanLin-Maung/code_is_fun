import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mobile_education/Api/api.dart';
import 'package:mobile_education/screens/featured_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

const domain = "https://coding-is-fun.onrender.com/api/v1";

//  class API {
//   login(String email, password) async {
//     try {
//       var response = await http.post(
//         Uri.parse('$domain/login'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(
//           {'email': email, 'password': password},
//         ),
//       );
//       return response;
//     } catch (err) {
//       throw Exception('Failed to connect to the server: $err');
//     }
//   }

  
//}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // bool isObscure = true; // for password show or hide
  bool isLoading = false;
  // bool _isHide = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _signup() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var response = await API().signup(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
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
    } else if (response.statusCode == 400) {
      if (res["success"] == false) {
        var snackBar = SnackBar(content: Text('${res["message"]}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print('Failed to signup. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your UI code here
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                // Color.fromARGB(255, 43, 42, 48),
                // Color.fromARGB(255, 85, 4, 206),
                // Color.fromARGB(255, 142, 138, 149)
                Colors.blueGrey.shade900,
                Colors.blueGrey.shade700,
                Colors.blueGrey.shade400
              ]
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: 
                        const Text(
                          'Create Your\nAccount',
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 35),
                        ),
                    ),
                    const SizedBox(height: 20,),
              FadeInUp(
                      duration: const Duration(milliseconds: 1300), 
                      child: const Text(
                        "SignUp Here!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        
                        FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: Container(
                            child: Column(
        
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    label: Text(
                                      "Enter your Name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ),
                                ),
                                TextField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    label: Text(
                                      " Enter your Email ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    
                                  ),
                                ),
                                TextField(
                                  controller: _passwordController,
                                  obscureText: true, // Use obscureText for password fields
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.password),
                                    // suffixIcon: IconButton(
                                    //       icon: Icon(_isHide
                                    //           ? Icons.visibility_off
                                    //           : Icons.visibility),
                                    //       onPressed: () {
                                    //         setState(() {
                                    //           _isHide = !_isHide;
                                    //         });
                                    //       },
                                    //     ),
                                    label: Text(
                                      "Password",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    
                                  ),
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.password),
                                    label: Text(
                                      "Confirm Password",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                        const SizedBox(height: 40,),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1500),
                          child: Container(
                            height: 50,width: 300,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const RadialGradient(
                              colors: [
                              Color.fromARGB(255, 52, 71, 81),
                              Color.fromARGB(255, 30, 39, 44),
                              ],
                              radius: 0.9,
                            ),
                          ),
                          child: const Center(
                            child: Text('SIGN IN',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white
                          ),
                          ),
                          ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text("Already have an account? "),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context, 
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          const LoginScreen()
                                        )
                                      );
                                    }, 
                                    child: const Text("Login",
                                    style: TextStyle(color: Colors.blue,),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ),
                        
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}





// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_education/screens/login_screen.dart';


// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }


// class _SignUpScreenState extends State<SignUpScreen> {
  
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool isObscure = true; // for password show or hide
//   bool isLoading =  false;
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//     );
//   }
// }

// children: [
                              //   Text(
                              //     "Already have an account?",
                              //     style: TextStyle(
                              //       color: Colors.grey,
                              //     ),
                              //   ),
                                
                              // ]
                        
            //             FadeInUp(
            //   duration: const Duration(milliseconds: 1700),
            //   child: Center(
                
            //     child: ElevatedButton(
            //       onPressed: () {
            //         // _handleGoogleSignIn(context);
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.red, // Choose your button color
            //       ),
            //       child: const Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           // Image.asset(
            //           //   'assets/images/google_logo.png',  // Replace with the path to your Google logo image
            //           //   height: 30,
            //           //   width: 30,
            //           // ),
            //           // SizedBox(width: 10),
            //           Text(
            //             'Sign in with Google',
            //             style: TextStyle(fontSize: 16, color: Colors.white),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),



// Widget build(BuildContext context) {
//   double bottomOverflow = 218.0;
//   double totalHeight = MediaQuery.of(context).size.height;
//   double containerHeight = totalHeight - bottomOverflow;

//   return Scaffold(
//     body: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(height: 40,),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 1000),
//                   child: const Text(
//                     'Create Your\nAccount',
//                     style: TextStyle(
//                       color: Colors.white, 
//                       fontSize: 35),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 1300), 
//                   child: const Text(
//                     "SignUp Here!",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(height: 20,),
//           Expanded(
//             child: Container(
//               height: containerHeight,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50),
//                   topRight: Radius.circular(50),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: <Widget>[
//                     FadeInUp(
//                       duration: const Duration(milliseconds: 1400),
//                       child: Container(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             TextField(
//                               controller: _nameController,
//                               decoration: InputDecoration(
//                                 label: Text(
//                                   "Enter your Name",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.grey,
//                                   ),
//                                 )
//                               ),
//                             ),
//                             TextField(
//                               controller: _emailController,
//                               decoration: InputDecoration(
//                                 label: Text(
//                                   " Enter your Email ",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.grey,
//                                   ),
//                                 )
//                               ),
//                             ),
//                             TextField(
//                               controller: _passwordController,
//                               obscureText: true, // Use obscureText for password fields
//                               decoration: InputDecoration(
//                                 label: Text(
//                                   "Password",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.grey,
//                                   ),
//                                 )
//                               ),
//                             ),
//                             TextField(
//                               decoration: InputDecoration(
//                                 label: Text(
//                                   "Confirm Password",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.grey,
//                                   ),
//                                 )
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ),
//                     const SizedBox(height: 40,),
//                     FadeInUp(
//                       duration: const Duration(milliseconds: 1500),
//                       child: Container(
//                         height: 50,width: 300,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           gradient: const RadialGradient(
//                             colors: [
//                               Color.fromARGB(255, 52, 71, 81),
//                               Color.fromARGB(255, 30, 39, 44),
//                             ],
//                             radius: 0.9,
//                           ),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'SIGN IN',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               color: Colors.white
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10,),
//                     FadeInUp(
//                       duration: const Duration(milliseconds: 1600),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 const Text("Already have an account? "),
//                                 TextButton(
//                                   onPressed: (){
//                                     Navigator.push(
//                                       context, 
//                                       MaterialPageRoute(
//                                         builder: (BuildContext context) =>
//                                         const LoginScreen()
//                                       )
//                                     );
//                                   }, 
//                                   child: const Text(
//                                     "Login",
//                                     style: TextStyle(color: Colors.blue,),
//                                   )
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }

