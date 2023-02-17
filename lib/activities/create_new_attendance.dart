import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_attendance/data.classes/attendance.dart';
import 'package:qr_attendance/database/db_provider.dart';
import 'package:qr_attendance/strings/strings.dart';

class CreateAttendance extends StatefulWidget {
  const CreateAttendance({super.key});

  @override
  State<CreateAttendance> createState() => _CreateAttendanceState();
}

class _CreateAttendanceState extends State<CreateAttendance> {
  final _formKey = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final detailsCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameCtr.dispose();
    detailsCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Create New Attendance')),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              controller: nameCtr,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.receipt_outlined),
                                  hintText: attendanceName,
                                  labelText: attendanceName),
                              validator: (value) =>
                                  (value!.isEmpty) ? nameError : null),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: detailsCtr,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.info_outline_rounded),
                              hintText: attendanceDetails,
                              labelText: attendanceDetails,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         DatePicker.showDateTimePicker(context,
                  //             showTitleActions: true, onConfirm: (date) {
                  //           timeCtr =
                  //               DateFormat('MMM d, yyyy h:mm a').format(date);
                  //         },
                  //             currentTime: DateTime.now(),
                  //             locale: LocaleType.en);
                  //       },
                  //       child: Text(
                  //         timeCtr,
                  //         style: const TextStyle(
                  //             fontSize: 20, color: Colors.white),
                  //       )),
                  // ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              DBProvider.db.insertAttendance(Attendance(
                                  name: nameCtr.text,
                                  details: detailsCtr.text.isEmpty
                                      ? ''
                                      : detailsCtr.text,
                                  time: DateFormat('MMM d, yyy h:mm a')
                                      .format(DateTime.now())));
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            save,
                            style: const TextStyle(fontSize: 20),
                          ))),
                ]),
          )
        ])));
  }
}
