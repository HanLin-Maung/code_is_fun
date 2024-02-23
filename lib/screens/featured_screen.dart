import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:mobile_education/api.dart';
import 'package:mobile_education/constants/color.dart';
import 'package:mobile_education/constants/size.dart';
import 'package:mobile_education/screens/course_screen.dart';
import 'package:mobile_education/screens/imgae_upload.dart';
import 'package:mobile_education/widgets/circle_button.dart';
import 'package:mobile_education/widgets/search_field.dart';
import 'package:shared_preferences/shared_preferences.dart';


List categoryList = [];

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var response = await API().categoryList();

      if (response.statusCode == 201) {
        var res = json.decode(response.body);
        if (res["success"] == true) {
          setState(() {
            categoryList = res['categories'];
          });
        }
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (err) {
      print('Error fetching categories: $err');
    }
  }

  // Future<void> fetchCategories() async{
  //     var response = await API().categoryList();

  //     if(response.statusCode == 200) {
  //       var jsonResponse = json.decode(response.body);

  //       setState(() {
  //         categoryList = jsonResponse['categories'];
  //       });
  //     } else {
  //       throw Exception('Failed to load categories');
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            AppBar(),
            Body(categories: categoryList),
          ],
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key, required this.categories});

  final List categories;

  @override
  State<Body> createState() => _BodyState();
}

// class _BodyState extends State<Body> {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Explore Categories",
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     "See All",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(color: kPrimaryColor),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           GridView.builder(
//             shrinkWrap: true,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 10,
//             ),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.8,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 24,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const CourseScreen(),
//                   ),
//                 ),
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(.1),
//                           blurRadius: 4.0,
//                           spreadRadius: .05,
//                         )
//                       ]),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: Image.network(
//                           categoryList[index]["cover"],
//                           height: kCategoryCardImageSize,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(categoryList[index]["title"]),
//                       Text(
//                         '${categoryList[index]["description"]} courses',
//                         style: Theme.of(context).textTheme.bodySmall,
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//             itemCount: widget.categories.length,
//           ),
//         ],
//       ),
//     );
//   }
// }

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return SingleChildScrollView(
    child: Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explore Categories",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See All",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: kPrimaryColor),
                  ),
                )
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,

              vertical: 20,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWideScreen ? 4 : 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CourseScreen(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 4.0,
                          spreadRadius: .05,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Image.network(
                          categoryList[index]["cover"],
                          height: kCategoryCardImageSize,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(categoryList[index]["title"]),
                      Text(
                        '${categoryList[index]["description"]} courses',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: widget.categories.length,
          ),
        GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const ImageUpload()));
                // Handle tap event for the new category card
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 4.0,
                      spreadRadius: .05,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add your category card content here
                    Text("New Category"),
                    // Add more widgets as needed
                  ],
                ),
              ),
            ),
        ],
      ),
    ),);
  }
}

//           GridView.builder(
//   shrinkWrap: true,
//   padding: const EdgeInsets.symmetric(
//     horizontal: 20,
//     vertical: 10,
//   ),
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
//     childAspectRatio: 0.8,
//     crossAxisSpacing: 20,
//     mainAxisSpacing: 24,
//   ),
//   itemBuilder: (BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const CourseScreen(),
//         ),
//       ),
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
//                 categoryList[index]["cover"],
//                 height: kCategoryCardImageSize,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(categoryList[index]["title"]),
//             Text(
//               '${categoryList[index]["description"]} courses',
//               style: Theme.of(context).textTheme.bodySmall,
//             )
//           ],
//         ),
//       ),
//     );
//   },
//   itemCount: widget.categories.length,
// ),


class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: RadialGradient(
          colors: [
            Color.fromARGB(255, 52, 71, 81),
            Color.fromARGB(255, 30, 39, 44),
          ],
          radius: 0.9,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,\nWelcome Back',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CircleButton(icon: Icons.notifications, onPressed: () {}),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SearchTextField()
        ],
      ),
    );
  }
}
