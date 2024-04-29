import 'package:flutter/material.dart';
import 'package:gallery/FullScreenImage.dart';
import 'package:gallery/image_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderClass>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisExtent: 150.0,
        ),
        itemCount: imageProvider.images.length,
        itemBuilder: (context, index) {
          final imageFile = imageProvider.images[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImageScreen(
                    imageFile: imageFile,
                    index: index,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: imageFile.existsSync()
                  ? Image.file(
                      imageFile,
                      fit: BoxFit
                          .contain, // Changed from BoxFit.cover to BoxFit.contain
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        // Display a placeholder or error message
                        return Placeholder();
                      },
                    )
                  : Placeholder(), // Display a placeholder if image file doesn't exist
            ),
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
