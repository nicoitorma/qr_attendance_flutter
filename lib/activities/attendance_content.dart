import 'package:flutter/material.dart';
import 'package:qr_attendance/activities/scanner.dart';

class Contents extends StatefulWidget {
  const Contents({super.key, required this.title});

  final String title;

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  int? _id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _id = 1;
        }),
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
    );
  }

  Widget body() {
    if (_id == 1) {
      return const QRScanner();
    }
    return ListView(
      children: const [Text('data')],
    );
  }
}
