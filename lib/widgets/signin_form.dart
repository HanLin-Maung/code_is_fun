import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// loginUser() async {
//     var body = {"email": "han@gmail.com", "password": "123456"};
//     var response = await http.post(
//       Uri.parse("https://coding-is-fun.onrender.com/api/v1/login"),
//       headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//       body: jsonEncode(body),
//     );
//     print(response.statusCode);
//     print(response.body);
//     setState(() {});
//   }

  // void login(String email, password){
  //   try{
  //     var response = post(
  //       Uri.parse('https://coding-is-fun.onrender.com/api/v1/login'),
  //       body: 
  //     );
  //   } catch {

  //   }
  // }

   // login(_emailController.text.toString(),_passwordController.text.toString());
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const BaseScreen()));



  // void login(String email, password) async{
  //   try{
  //     var response = await post(Uri.parse('https://coding-is-fun.onrender.com/api/v1/login'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode({
  //       'email': email,
  //       'password': password}),
  //     );

  //     if(response.statusCode == 200){
  //       print('account login');
  //       print(response.statusCode);
  //       print(response.body);
  //       setState(() {});
  //     }else{
  //       print('failed');
  //     }

  //   }catch(err){
  //     print(err.toString());
  //   }
  // } 


//   import 'package:flutter/material.dart';

// class YourWidget extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         colors: [
  //           Colors.blueGrey.shade900,
  //           Colors.blueGrey.shade700,
  //           Colors.blueGrey.shade400
  //         ],
  //       )),
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
  //                 const FadeInUp(
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
  //                 const FadeInUp(
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
// }
