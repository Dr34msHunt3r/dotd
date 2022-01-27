import 'package:dotd/config/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RecipesImageSection extends StatelessWidget {
  RecipesImageSection({Key? key, required this.image, required this.onImageChanged}) : super(key:  key);

  final File? image;
  final Function(ImageSource) onImageChanged;

  @override
  Widget build(BuildContext context){
    return Stack(
        alignment: Alignment.bottomRight,
        children: [
          image != null ? Image.file(image!, key: UniqueKey()) : Image(image: AssetImage(AppAssets.defaultRecipeImage)),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, right: 20.0),
            child: FloatingActionButton(
                child: Icon(Icons.add_a_photo),
                onPressed: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Wrap(children: [
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Camera'),
                          onTap: () {
                            Navigator.pop(context);
                            onImageChanged(ImageSource.camera);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_album),
                          title: Text('Gallery'),
                          onTap: () {
                            Navigator.pop(context);
                            onImageChanged(ImageSource.gallery);
                          },
                        )
                      ],
                      )
                  );
                }
            ),
          )
        ]
    );
  }

}


