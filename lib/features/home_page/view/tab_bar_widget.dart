import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabs,
    this.isScrollable = true,
  });

  final List<String> tabs;
  final bool isScrollable;
  static const List<Color> categoryColor = [
    Color.fromARGB(255, 32, 74, 172),
    Color.fromARGB(255, 114, 22, 148),
    Color.fromARGB(255, 69, 139, 215),
    Color.fromARGB(255, 248, 8, 8),
    Color.fromARGB(255, 94, 63, 2),
    Color.fromARGB(255, 70, 41, 9),
    Color.fromARGB(255, 89, 54, 12),
    Color.fromARGB(255, 175, 16, 144),
    Color.fromARGB(255, 13, 147, 95),
    Color.fromARGB(255, 237, 106, 13),
  ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 30,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: tabs.length,
//         itemBuilder: (BuildContext context, int idx) {
//           return TextButton(
//             onPressed: (){},
//             child: Container(
//               color: categoryColor[idx],
//               child: Row(
//                 children: [
//                   const Icon(Icons.info,),
//                   Text(tabs[idx], selectionColor: Colors.black,),
//                 ],),
//             ),

//           );
//         },
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      physics: const BouncingScrollPhysics(),
      isScrollable: isScrollable,
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16.0,
        ),
        color: Colors.black,
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black,
      tabs: List.generate(
        tabs.length,
        (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: categoryColor[index],
          ),
          child: Tab(
            child: Row(
              children: [const Icon(Icons.info), Text(tabs[index])],
            ),
          ),
        ),
      ),
    );
  }
}
