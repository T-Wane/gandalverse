import 'package:flutter/material.dart';
import 'package:gandalverse/core/services/QG_services/QGService.dart';

class CardUpdateWidget extends StatelessWidget {
  final QGService service;

  CardUpdateWidget({required this.service});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: service.loadingStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black45,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                content: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(3),
                      child: CircularProgressIndicator(
                        color: Colors.white70,
                        strokeWidth: 1.5,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Mise à jour de la carte en cours...",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                duration: Duration(),
              ),
            );
          });
          return SizedBox.shrink();
        } else {
          // Optionally, clear the SnackBar when loading is done
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          });
          return SizedBox.shrink();
        }
      },
    );
  }
}
