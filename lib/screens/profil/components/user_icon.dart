import 'package:flutter/material.dart';

class userIcon extends StatelessWidget {
  const userIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            height: 1,
            color: Colors.white60,
          ),
        )),
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 8,
            ),
            child: Icon(
              Icons.person_outline_sharp,
              color: Colors.grey.shade500,
              size: 25.0,
            ),
          ),
        ),
        const Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            height: 1,
            color: Colors.white60,
          ),
        )),
      ],
    );
  }
}
