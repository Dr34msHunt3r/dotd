import 'package:dotd/presentation/widgets/image_source_differentiater_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecipesImageSection extends StatelessWidget {
  RecipesImageSection({Key? key, required this.imageUrl, required this.onImageChanged}) : super(key:  key);

  final String? imageUrl;
  final Function(ImageSource) onImageChanged;

  @override
  Widget build(BuildContext context){
    return Stack(
        alignment: Alignment.bottomRight,
        children: [
          imageSourceDisplayer(imageUrl),
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


