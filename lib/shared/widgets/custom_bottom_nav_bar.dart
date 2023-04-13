// import 'package:dropandgouser/shared/helpers/colors.dart';
// import 'package:flutter/material.dart';
//
// class CustomBottomNavBar extends StatefulWidget {
//   final Function onItemTapped;
//   final bool value;
//   final int selectedIndex;
//
//   const CustomBottomNavBar(
//       {super.key, required this.onItemTapped,
//         required this.selectedIndex,
//         this.value = false,
//         });
//
//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavState();
// }
//
// class _CustomBottomNavState extends State<CustomBottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//         data: ThemeData(
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//         ),
//         child: ValueListenableBuilder<int>(
//             valueListenable: selectedIndex,
//             builder: (s, int value, child) {
//               return Container(
//                   decoration: const BoxDecoration(
//                     color: DropAndGoColors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(32.0),
//                         topRight: Radius.circular(32.0)),
//                   ),
//                   child: BottomNavigationBar(
//                     backgroundColor: Colors.transparent,
//                     showUnselectedLabels: true,
//                     type: BottomNavigationBarType.fixed,
//                     elevation: 0,
//                     items: _navBarsItems(widget.value, value),
//                     currentIndex: value,
//                     selectedItemColor: LocalWalkersColors.brown,
//                     selectedFontSize: 12,
//                     unselectedFontSize: 12,
//                     unselectedItemColor: LocalWalkersColors.dark,
//                     onTap: (value)=>widget.onItemTapped(value),
//                   ));
//             }));
//   }
//
//   List<BottomNavigationBarItem> _navBarsItems(bool value, int indexValue) {
//     return [
//
//       BottomNavigationBarItem(
//         icon: Column(
//           children: [
//             15.verticalGap,
//             SvgWidget(
//               imgPath:
//               LocalWalkersIcons.icHomeNav,
//               color: indexValue == 0 ? LocalWalkersColors.brown:LocalWalkersColors.dark,
//               fit: BoxFit.contain,
//             ),
//             12.verticalGap,
//             StandardText.headline1(context, 'Home',fontSize: 12,color: indexValue == 0 ? LocalWalkersColors.brown:LocalWalkersColors.dark,fontFamily: LocalWalkersFontFamily.interMedium,fontWeight: FontWeight.w400,)
//           ],
//         ),
//         label: '',
//       ),
//       BottomNavigationBarItem(
//           icon: Column(
//             children: [
//               15.verticalGap,
//               SvgWidget(
//                 imgPath: LocalWalkersIcons.icWalkNav,
//                 color: indexValue == 1 ? LocalWalkersColors.brown:LocalWalkersColors.dark,
//                 fit: BoxFit.contain,
//               ),
//               5.verticalGap,
//               StandardText.headline1(context, 'My walks',fontSize: 12,color: indexValue == 1 ? LocalWalkersColors.brown:LocalWalkersColors.dark,fontFamily: LocalWalkersFontFamily.interMedium,fontWeight: FontWeight.w400,)
//             ],
//           ),
//           label: ''),
//       BottomNavigationBarItem(
//           icon: Column(
//             children:  [
//               47.verticalGap,
//               StandardText.headline1(context, 'New Walk',fontSize: 12,fontFamily: LocalWalkersFontFamily.interMedium,fontWeight: FontWeight.w400,color: indexValue == 2 ? LocalWalkersColors.brown:LocalWalkersColors.dark,)
//             ],
//           ),
//           label: ''),
//
//       BottomNavigationBarItem(
//
//         icon: Column(
//
//           children: [
//             15.verticalGap,
//             SvgWidget(
//               imgPath:
//               LocalWalkersIcons.icFlag,
//               color: indexValue == 3 ? LocalWalkersColors.brown:LocalWalkersColors.dark,
//               fit: BoxFit.contain,
//             ),
//             5.verticalGap,
//             StandardText.headline1(context, 'New POI',fontSize: 12,fontFamily: LocalWalkersFontFamily.interMedium,fontWeight: FontWeight.w400,color: indexValue == 3 ? LocalWalkersColors.brown:LocalWalkersColors.dark,)
//           ],
//         ),
//         label: '',
//       ),
//       BottomNavigationBarItem(
//         icon: SizedBox(
//             child: Column(
//
//               children: [
//                 15.verticalGap,
//                 SvgWidget(
//                   imgPath:
//                   LocalWalkersIcons.icProfile,
//                   color: indexValue == 4 ? LocalWalkersColors.brown:LocalWalkersColors.dark,
//                   fit: BoxFit.contain,
//                 ),
//                 12.verticalGap,
//                 StandardText.headline1(context, 'Profile',fontSize: 12,fontFamily: LocalWalkersFontFamily.interMedium,fontWeight: FontWeight.w400,color: indexValue == 4 ? LocalWalkersColors.brown:LocalWalkersColors.dark,)
//               ],
//             )),
//         label: '',
//       ),
//     ];
//   }
// }