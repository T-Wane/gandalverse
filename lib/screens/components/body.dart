import 'package:flutter/material.dart'; 

class HomeScreenBody extends StatefulWidget {
  int currentIndex;
  HomeScreenBody({super.key, required this.currentIndex});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Center(child: getBody());
  }

  Widget getBody() {
    List<Widget> pages = [ 
      Container(),
      Container(),
      Container(),
      Container(),
    ];
    return IndexedStack(
      index: widget.currentIndex,
      children: pages,
    );
  }
}
