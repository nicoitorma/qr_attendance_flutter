import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendance/activities/attendance_list.dart';
import 'package:qr_attendance/activities/create_new_attendance.dart';
import 'package:qr_attendance/data.classes/master_list.dart';
import 'package:qr_attendance/database/db_provider.dart';
import 'package:qr_attendance/ui.elements.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'QR Attendance'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? filepath;
  String? filename;

  @override
  void initState() {
    DBProvider.db.initDB();
    super.initState();
  }

  Future<void> pickExcel() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      filepath = File(result.files.single.path!);
      filename = result.files.first.name;

      DBProvider.db.insertMasterlistFile(
          FileMasterList(filepath: filepath.toString(), filename: filename!));
    } else {
      debugPrint("No file selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            mainAxisSpacing: 15,
            childAspectRatio: 2 / 2,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () => pickExcel(),
                child: customCard(
                    icon: Icons.upload_file, title: 'Upload Masterlist'),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateAttendance())),
                child: customCard(
                    icon: Icons.edit_note, title: 'Create New Attendance'),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AttendanceList())),
                child: customCard(
                    icon: Icons.checklist_rtl, title: 'Attendance List'),
              ),
              GestureDetector(
                  child: customCard(icon: Icons.qr_code_2, title: 'Create QR')),
            ],
          ),
        ));
  }
}
