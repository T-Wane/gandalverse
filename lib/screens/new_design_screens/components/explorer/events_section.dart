import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/explorer/evenement/evenement.dart';
import 'package:gandalverse/core/services/explorer_service/explorer_service.dart';
import 'package:gandalverse/di/global_dependencies.dart';
import 'package:gandalverse/screens/new_design_screens/helper/ui_helper.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class EventsSection extends StatefulWidget {
  const EventsSection({super.key});

  @override
  State<EventsSection> createState() => _EventsSectionState();
}

class _EventsSectionState extends State<EventsSection> {
  ExplorerService _explorerService = getIt<ExplorerService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _explorerService.loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: realW(10)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: realW(10)),
              child: const Text(
                "Evenements",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildEventsZone()
          ]),
    );
  }

  Widget _buildEventsZone() {
    return FutureBuilder<List<EvenementModel>>(
      future: _explorerService.getEvents(),
      builder:
          (BuildContext context, AsyncSnapshot<List<EvenementModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Event found'));
        } else {
          List<EvenementModel> dataList = snapshot.data!;
          return Container(
            height: realH(150),
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  EvenementModel evenement = dataList[index];
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(2),
                    width: realW(250),
                    child: Stack(children: [
                      CustomImageView(
                        imagePath: evenement.image!,
                        fit: BoxFit.cover,
                        radius: BorderRadius.circular(10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                colors: [
                                  Colors.black12,
                                  Colors.black38,
                                  Colors.black45,
                                  Colors.black54,
                                  Colors.black87,
                                ],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter)),
                      ),
                      Positioned(
                        bottom: realH(10),
                        left: realW(10),
                        child: Text(
                          "Marshmello Live in Concert",
                          style: TextStyle(
                              color: Colors.white, fontSize: realW(14)),
                        ),
                      )
                    ]),
                  );
                }),
          );
        }
      },
    );
  }
}
