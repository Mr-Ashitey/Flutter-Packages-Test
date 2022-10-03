import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  double progress = 0;
  final Dio dio = Dio();

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<bool> saveVideo(String url, String fileName) async {
    // Code for Downloading and Saving Content will go here
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            // manage external storage needed for android 11/R
            await _requestPermission(Permission.manageExternalStorage)) {
          directory = await getExternalStorageDirectory();

          String newPath = "";
          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/APK";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File("${directory.path}/$fileName");
        if (await saveFile.exists()) {
          await saveFile.delete();
        }

        await dio.download(url, saveFile.path,
            onReceiveProgress: (actualBytes, totalBytes) {
          setState(() {
            progress = actualBytes / totalBytes;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        OpenFile.open(saveFile.path);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  void downloadFile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    // saveVideo will download and save file to Device and will return a boolean
    // for if the file is successfully or not
    bool downloaded = await saveVideo(
        "https://pmob.cardinalapps.net/downloads/apps/powerdischarge.apk",
        "discharge.apk");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(progress.toString()),
                    LinearProgressIndicator(
                      minHeight: 10,
                      value: progress,
                    ),
                  ],
                ),
              )
            : ElevatedButton.icon(
                icon: const Icon(Icons.download_rounded, color: Colors.white),
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: downloadFile,
                label: const Text(
                  "Download Apk",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
      ),
    );
  }
}
