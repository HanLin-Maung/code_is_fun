// import 'package:flutter/material.dart';
// import 'package:mobile_education/constants/size.dart';
// import 'package:mobile_education/models/category.dart';
// import 'package:mobile_education/screens/course_screen.dart';

// class CategoryCard extends StatelessWidget {
//   const CategoryCard({super.key, required this.category});

//   final Map<String, String> category;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () =>
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseScreen( )))
//       ,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.1),
//               blurRadius: 4.0,
//               spreadRadius: .05,
//             )
//           ]
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: Image.network(
//                 category.cover,
//                 height: kCategoryCardImageSize,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(category.title),
//             Text(
//               '${category.description} courses',
//               style: Theme.of(context).textTheme.bodySmall,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           colors: [
//             Colors.blueGrey.shade900,
//             Colors.blueGrey.shade700,
//             Colors.blueGrey.shade400
//           ],
//         )),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(height: MediaQuery.of(context).padding.top + 20),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     const FadeInUp(
//                       duration: const Duration(milliseconds: 1000),
//                       child: const Text(
//                         "Coding is fun",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 35,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const FadeInUp(
//                       duration: const Duration(milliseconds: 1300),
//                       child: const Text(
//                         "Welcome",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(50),
//                       topRight: Radius.circular(50),
//                     )),
//                 child: Padding(
//                   padding: const EdgeInsets.all(30),
//                   child: Column(
//                     children: <Widget>[
//                       const SizedBox(
//                         height: 60,
//                       ),
//                       FadeInUp(
//                         duration: const Duration(milliseconds: 1400),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Color.fromRGBO(28, 21, 18, 0.298),
//                                     blurRadius: 20,
//                                     offset: Offset(0, 10))
//                               ]),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     border: Border(
//                                       bottom: BorderSide(
//                                           color: Colors.grey.shade200),
//                                     ),
//                                   ),
//                                   child: TextField(
//                                     controller: _emailController,
//                                     obscureText: true,
//                                     decoration: InputDecoration(
//                                         hintText: 'Email or Phone number',
//                                         hintStyle:
//                                             TextStyle(color: Colors.grey),
//                                         border: InputBorder.none),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     border: Border(
//                                       bottom: BorderSide(
//                                           color: Colors.grey.shade200),
//                                     ),
//                                   ),
//                                   child: TextField(
//                                     controller: _passwordController,
//                                     obscureText: true,
//                                     decoration: const InputDecoration(
//                                         hintText: 'Password',
//                                         hintStyle:
//                                             TextStyle(color: Colors.grey),
//                                         border: InputBorder.none),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       FadeInUp(
//                           duration: Duration(milliseconds: 1600),
//                           child: MaterialButton(
//                             onPressed: () {
//                               _login();
//                               setState(() {});
//                             },
//                             height: 40,
//                             color: Colors.blueGrey[800],
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: Center(
//                               child: isLoading
//                                   ? const SpinKitRing(
//                                       color: Colors.white,
//                                       size: 25,
//                                       lineWidth: 2,
//                                     )
//                                   : const Text(
//                                       "LOGIN",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                             ),
//                           ))
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }