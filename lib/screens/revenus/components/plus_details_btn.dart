import 'package:flutter/material.dart';
import 'package:gandalverse/widgets/popups/revenuDetails_alert.dart';

class plusDetailsBtn extends StatelessWidget {
  const plusDetailsBtn({
    super.key,
    required this.Color3,
  });

  final Color Color3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (_) => RevenuDetails_PopUp(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Plus de détails',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color3,
                fontFamily: "Aller",
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Color3,
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
