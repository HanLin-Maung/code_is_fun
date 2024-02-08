// import 'package:flutter/material.dart';
// import 'package:mobile_education/constants/color.dart';
// import 'package:mobile_education/constants/icons.dart';
// import 'package:mobile_education/constants/size.dart';
// import 'package:mobile_education/screens/featured_screen.dart';

// class BaseScreen extends StatefulWidget {
//   const BaseScreen({super.key});

//   @override
//   State<BaseScreen> createState() => _BaseScreenState();
// }

// class _BaseScreenState extends State<BaseScreen> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     FeaturedScreen(),
//     FeaturedScreen(),
//     FeaturedScreen(),
//     FeaturedScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: kPrimaryColor,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         items: [
//           BottomNavigationBarItem(
//             activeIcon: Image.asset(
//               icFeatured,
//               height: kBottomNavigationBarItemSize,
//             ),
//             icon: Image.asset(
//               icFeaturedOutlined,
//               height: kBottomNavigationBarItemSize,
//             ),
//             label: "Featured",
//           ),
//           BottomNavigationBarItem(
//             activeIcon: Image.asset(
//               icLearning,
//               height: kBottomNavigationBarItemSize,
//             ),
//             icon: Image.asset(
//               icLearningOutlined,
//               height: kBottomNavigationBarItemSize,
//             ),
//             label: "My Learning",
//           ),
//           // BottomNavigationBarItem(
//           //   activeIcon: Image.asset(
//           //     icWishlist,
//           //     height: kBottomNavigationBarItemSize,
//           //   ),
//           //   icon: Image.asset(
//           //     icWishlistOutlined,
//           //     height: kBottomNavigationBarItemSize,
//           //   ),
//           //   label: "Wishlist",
//           // ),
//           BottomNavigationBarItem(
//             activeIcon: Image.asset(
//               icSetting,
//               height: kBottomNavigationBarItemSize,
//             ),
//             icon: Image.asset(
//               icSettingOutlined,
//               height: kBottomNavigationBarItemSize,
//             ),
//             label: "Settings",
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: (int index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
