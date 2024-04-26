import 'package:flutter/material.dart';
import 'package:gallery/FullScreenImage.dart';
import 'package:gallery/image_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderClass>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 8.0, mainAxisExtent: 150.0),
        itemCount: imageProvider.images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullScreenImageScreen(
                          imageFile: imageProvider.images[index],
                          index: index)));
            },
            child: Image.file(imageProvider.images[index], fit: BoxFit.cover),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pickedImage =
              await ImagePicker().getImage(source: ImageSource.gallery);
          if (pickedImage != null) {
            imageProvider.addImage(File(pickedImage.path));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
