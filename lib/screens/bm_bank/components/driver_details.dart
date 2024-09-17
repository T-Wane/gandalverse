// import 'package:angata/app/core/themes/theme_colors.dart';
// import 'package:angata/app/modules/module_a/customer/home/homepage.dart';
// import 'package:angata/components/ligne_details.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class driverDetails extends StatelessWidget {
//   driverDetails({
//     super.key,
//     required this.close,
//     required this.driverName,
//   });

//   VoidCallback close;
//   String driverName;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       left: 2.0,
//       right: 2.0,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: ThemeColors.blue.withOpacity(0.3),
//               blurRadius: 10,
//               spreadRadius: 0.5,
//               offset: Offset(0, -2),
//             )
//           ],
//         ),
//         child: Stack(children: [
//           Card(
//             elevation: 1.0,
//             surfaceTintColor: Colors.transparent,
//             color: ThemeColors.white,
//             margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: ListTile(
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//               leading: const CircleAvatar(
//                 backgroundColor: ThemeColors.blue,
//                 child: Icon(
//                   CupertinoIcons.person,
//                   color: ThemeColors.white,
//                 ),
//               ),
//               title: Text(
//                 driverName,
//                 style: GoogleFonts.lato(
//                   textStyle: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: ThemeColors.greyDeep,
//                   ),
//                 ),
//               ),
//               subtitle: Column(
//                 children: [
//                   detailsLigne(
//                     paddingV: 2,
//                     titre: "Telephone",
//                     data: '+223 65567057',
//                     nLigne: 1,
//                     dataColor: ThemeColors.greyDeep,
//                   ),
//                   detailsLigne(
//                     paddingV: 2,
//                     titre: "Type voiture",
//                     data: 'Climée',
//                     nLigne: 1,
//                     dataColor: ThemeColors.greyDeep,
//                   ),
//                   detailsLigne(
//                     paddingV: 2,
//                     titre: "Distance",
//                     data: '2 Km',
//                     nLigne: 1,
//                     dataColor: ThemeColors.greyDeep,
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: StarRating(
//                       rating: 3.5,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: -10,
//             right: 2.0,
//             child: IconButton(
//               onPressed: close,
//               icon: const Icon(CupertinoIcons.clear_circled),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }
