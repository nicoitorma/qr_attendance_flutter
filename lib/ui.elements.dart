import 'package:flutter/material.dart';

Widget customCard({required IconData icon, required String title}) {
  return Card(
    elevation: 5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(icon, size: 100),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}

Widget card(
    {required String text1, required String text2, required String text3}) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        color: Colors.blue[200],
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text1, style: const TextStyle(fontSize: 20)),
            ),
            text2 != ''
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text2, style: const TextStyle(fontSize: 18)),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text3, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ));
}
