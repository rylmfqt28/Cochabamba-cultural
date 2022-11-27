import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadImages {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadPrincipalImage(String path, String uid) async {
    String _imagePrincipal = "";

    if (path.contains("https://")) {
      return path;
    }

    final principalImage = File(path);

    await _storage
        .ref()
        .child('events/$uid/$uid-principal')
        .putFile(principalImage)
        .then((TaskSnapshot taskSnapshot) async {
      await taskSnapshot.ref
          .getDownloadURL()
          .then((value) => {_imagePrincipal = value});
    });

    return _imagePrincipal;
  }

  Future<List<String>> uploadSecondaryImages(
      List<String> imagesPath, String uid) async {
    List<String> _paths = [];

    int _index = 0;

    for (var path in imagesPath) {
      if (path.contains("https://")) {
        _paths.add(path);
      } else {
        File _newImage = File(path);

        await _storage
            .ref()
            .child('events/$uid/secondary/$_index')
            .putFile(_newImage)
            .then((TaskSnapshot taskSnapshot) async {
          await taskSnapshot.ref.getDownloadURL().then((value) {
            _paths.add(value);
            _index++;
          });
        });
      }
    }

    return _paths;
  }
}
