import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendance/activities/attendance_content.dart';
import 'package:qr_attendance/database/db_provider.dart';
import 'package:qr_attendance/strings/strings.dart';
import 'package:qr_attendance/ui.elements.dart';

class AttendanceList extends StatefulWidget {
  const AttendanceList({super.key});

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  int? _id;
  String title = defaultTitle;

  Widget bodyFunction() {
    if (_id == 0) {
      return Contents(title: title);
    }
    return attendanceList();
  }

  Widget attendanceList() => Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            ExpansionTileCard(
              baseColor: Colors.blue[300],
              title: const Text('Masterlist'),
              children: [
                FutureBuilder(
                  future: DBProvider.db.retrieveMasterlist('Masterlist'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(color: Colors.blue));
                    }
                    return ListView(
                        shrinkWrap: true,
                        children: snapshot.data!
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _id = 0;
                                      title = e.filename;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      color: Colors.blue[200],
                                    ),
                                    margin: const EdgeInsets.all(8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e.filename,
                                          style: const TextStyle(fontSize: 20)),
                                    ),
                                  ),
                                ))
                            .toList());
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            ExpansionTileCard(
              baseColor: Colors.blue[300],
              title: const Text('Attendance list'),
              children: [
                FutureBuilder(
                  future: DBProvider.db.retrieveMasterlist('Attendancelist'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(color: Colors.blue));
                    }
                    return ListView(
                        shrinkWrap: true,
                        children: snapshot.data!
                            .map((e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _id = 0;
                                    title = e.name;
                                  });
                                },
                                child: card(
                                    text1: e.name,
                                    text2: e.details,
                                    text3: e.time)))
                            .toList());
                  },
                )
              ],
            ),
          ],
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return bodyFunction();
  }
}
