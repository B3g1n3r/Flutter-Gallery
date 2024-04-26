import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery/HomePage.dart';
import 'package:gallery/image_provider.dart';
import 'package:provider/provider.dart';

class FullScreenImageScreen extends StatelessWidget {
  final File imageFile;
  final int index;

  FullScreenImageScreen({required this.imageFile, required this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final imageProvider = Provider.of<ImageProviderClass>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Image.file(imageFile),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Container(
                height: 200,
                width: size.width,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
                      imageProvider.removeImage(index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(title: 'Gallery')));
                    },
                  ),
                ),
                decoration: BoxDecoration(color: Colors.blueAccent)),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
