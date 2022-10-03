import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  double progress = 0;

  void downloadFile() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  minHeight: 10,
                  value: progress,
                ),
              )
            : FlatButton.icon(
                icon: Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                ),
                color: Colors.blue,
                onPressed: downloadFile,
                padding: const EdgeInsets.all(10),
                label: Text(
                  "Download Video",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
      ),
    );
  }
}
