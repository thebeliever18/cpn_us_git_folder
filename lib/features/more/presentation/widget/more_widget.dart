import 'package:flutter/material.dart';

Row onlineTileContentText(String title, String content) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 80.0,
        child: Text(title, style: const TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black87
        )),
      ),
      const Text('  :  '),
      Text(content, style: const TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black87
      )),
    ],
  );
}

Container offlineItemText(String title1, String content1, String title2, String content2) {
  return Container(
    padding: const EdgeInsets.only(top: 5, bottom: 10.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title1, style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 13.0
              )),
              const SizedBox(height: 3.0),
              Text(content1, style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 14.0
              )),
            ],
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title2, style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 13.0
              )),
              const SizedBox(height: 3.0),
              Text(content2, style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 14.0
              )),
            ],
          ),
        )
      ],
    ),
  );
}

Container cardAbb(String title1, String content1, String title2, String content2) {
  return Container(
    padding: const EdgeInsets.only(top: 5, bottom: 10.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title1, style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 13.0
              )),
              const SizedBox(height: 3.0),
              Text(content1, style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold
              )),
            ],
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title2, style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 13.0
              )),
              const SizedBox(height: 3.0),
              Text(content2, style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold
              )),
            ],
          ),
        )
      ],
    ),
  );
}