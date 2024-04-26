import 'package:flutter/material.dart';
import 'dart:io';

class ImageProviderClass extends ChangeNotifier {
  List<File> _images = [];
  List<File> get images => _images;

  void addImage(File image) {
    _images.add(image);
    notifyListeners();
  }

  void removeImage(int index) {
    _images.removeAt(index);
    notifyListeners();
  }
}
