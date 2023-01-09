import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final storageRef = FirebaseStorage.instance.ref();

  Future<List<String>?> upLoadImages(List<XFile> images) async {
    if (images.isNotEmpty) {
      List<String> urls = [];
      for (var i in images) {
        final mountainsRef =
            storageRef.child("images/${DateTime.now().day}/${i.name}");
        try {
          final file = File(i.path);
          final upLoadTask = await mountainsRef.putFile(file);
          final url = await upLoadTask.ref.getDownloadURL();
          urls.add(url);
        } catch (e) {
          log(e.toString());
        }
      }
      return urls;
    } else {
      return null;
    }
  }
}
