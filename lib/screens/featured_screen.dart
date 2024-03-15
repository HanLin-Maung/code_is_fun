import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_education/Api/api.dart';
import 'package:mobile_education/constants/color.dart';
import 'package:mobile_education/constants/size.dart';
import 'package:mobile_education/screens/course_screen.dart';
import 'package:mobile_education/widgets/add_category.dart';
import 'package:mobile_education/widgets/circle_button.dart';
import 'package:mobile_education/widgets/main_drawer.dart';

List categoryList = [];

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var response = await API().getCategoryList();

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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Builder(
        builder: (context) => Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const AppBar(),
                Body(categories: categoryList),
              ],
            ),
          ),
          drawer: const MainDrawer(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AddCategory()));
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Category'),
            backgroundColor: const Color.fromARGB(255, 27, 34, 75),
            foregroundColor: Colors.white,
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: (){},
          //   child: Icon(Icons.add),
          //   backgroundColor: Colors.grey,
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

class _BodyState extends State<Body> {
  bool showAllCategories = false;

  // Toggle between showing all categories and showing only a subset
  void toggleShowAllCategories() {
    setState(() {
      showAllCategories = !showAllCategories;
    });
  }

  // Truncate the description if it exceeds the maximum number of words
  String _truncateDescription(String description) {
    final int maxWords = 5;
    final words = description.split(' ');
    if (words.length <= maxWords) {
      return description;
    } else {
      final truncatedDescription = words.take(maxWords).join(' ') + '...';
      return truncatedDescription;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    final List<Widget> categoryItems = showAllCategories
        ? widget.categories.map<Widget>((category) {
            return _buildCategoryItem(category);
          }).toList()
        : widget.categories.take(4).map<Widget>((category) {
            return _buildCategoryItem(category);
          }).toList();

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
                    onPressed: toggleShowAllCategories,
                    child: Text(
                      showAllCategories ? "Show Less" : "See All",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: kPrimaryColor),
                    ),
                  )
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              crossAxisCount: isWideScreen ? 4 : 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: categoryItems,
            ),
          ],
        ),
      ),
    );
  }

  // Build category item widget
  Widget _buildCategoryItem(Map<String, dynamic> category) {
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
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Align(
            //   alignment: Alignment.topRight,
            //   child: CachedNetworkImage(
            //     imageUrl: category["cover"],
            //     height: kCategoryCardImageSize,
            //   ),
            // ),
            const SizedBox(height: 10),
            Text(category["title"]),
            Text(
              _truncateDescription(category["description"]),
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatefulWidget {
  const AppBar({super.key});

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 130,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 52, 71, 81),
              Color.fromARGB(255, 30, 39, 44),
            ],
            radius: 0.9,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 4,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
                color: Colors.white,
              ),
              Text(
                'Hello,\nWelcome Back',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CircleButton(icon: Icons.notifications, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

//import 'package:mobile_education/screens/imgae_upload.dart';
//         // Navigator.push(context, MaterialPageRoute(builder: (context) => const MainDrawer()))
//   Scaffold.of(context).openDrawer();

// class _BodyState extends State<Body> {
//   bool showAllCategories = false;

//   void toggleShowAllCategories(){
//     setState(() {
//       showAllCategories = !showAllCategories;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isWideScreen = screenWidth > 600;

//     return Container(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   "Explore Categories",
//                   style: Theme.of(context).textTheme.bodyLarge,
//                 ),
//                 // TextButton(
//                 //   onPressed: () {},
//                 //   child: Text(
//                 //     "See All",
//                 //     style: Theme.of(context)
//                 //         .textTheme
//                 //         .bodyMedium
//                 //         ?.copyWith(color: kPrimaryColor),
//                 //   ),
//                 // )
//               ],
//             ),
//           ),
//           GridView.builder(
//             shrinkWrap: true,
//             primary: false,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 20,
//             ),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: isWideScreen ? 4 : 2,
//               childAspectRatio: 0.75,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 20,
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
//                         ),
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
//         GestureDetector(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) =>const ImageUpload()));
//                 // Handle tap event for the new category card
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.1),
//                       blurRadius: 4.0,
//                       spreadRadius: .05,
//                     )
//                   ],
//                 ),
//                 child: FloatingActionButton.extended(
//                   foregroundColor: Colors.cyanAccent,
//                   backgroundColor: Colors.grey,
//                   elevation: 10.0,
//                   onPressed:(){
//                     Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const ImageUpload()));
//                   },
//                   label: const Text("New Category"),
//                   icon: const Icon(Icons.add),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _BodyState extends State<Body> {
//   bool showAllCategories = false;

// // Show  all categories or only those that are not empty
//   void toggleShowAllCategories() {
//     setState(() {
//       showAllCategories = !showAllCategories;
//     });
//   }

//   String _truncateDescription(String description) {
//     final int maxWords = 6;
//     final words = description.split(' ');
//     if (words.length <= maxWords) {
//       return description;
//     } else {
//       final truncatedDescription =
//           '${description.split(' ').take(maxWords).join(' ')}...';
//       return truncatedDescription;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isWideScreen = screenWidth > 600;

//     final List<Widget> categoryItems = showAllCategories
//         ? widget.categories.map<Widget>((category) {
//             return GestureDetector(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CourseScreen(),
//                 ),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.1),
//                       blurRadius: 4.0,
//                       spreadRadius: .05,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Image.network(
//                         category["cover"],
//                         height: kCategoryCardImageSize,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(category["title"]),
//                     Text(
//                       _truncateDescription(category["description"]),
//                       // '${category["description"]} courses',
//                       style: Theme.of(context).textTheme.bodySmall,
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }).toList()
//         : widget.categories.take(4).map<Widget>((category) {
//             return GestureDetector(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CourseScreen(),
//                 ),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.1),
//                       blurRadius: 4.0,
//                       spreadRadius: .05,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Image.network(
//                         category["cover"],
//                         height: kCategoryCardImageSize,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(category["title"]),
//                     Text(
//                       '${category["description"]} courses',
//                       style: Theme.of(context).textTheme.bodySmall,
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }).toList();

//     return SingleChildScrollView(
//       child: Container(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Explore Categories",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   TextButton(
//                     onPressed: toggleShowAllCategories,
//                     child: Text(
//                       showAllCategories ? "Show Less" : "See All",
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium
//                           ?.copyWith(color: kPrimaryColor),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             GridView.count(
//               shrinkWrap: true,
//               primary: false,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 20,
//               ),
//               crossAxisCount: isWideScreen ? 4 : 2,
//               childAspectRatio: 0.75,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 20,
//               children: categoryItems,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// const SizedBox(
//   height: 20,
// ),
// const SearchTextField()

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
//                   ),itemCount: widget.categories.length,
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

// FloatingActionButton.extended(
//   backgroundColor: const Color(0xff03dac6),
//   foregroundColor: Colors.black,
//   onPressed: () {
//     // Respond to button press
//   },
//   icon: Icon(Icons.add),
//   label: Text('EXTENDED'),
// )
