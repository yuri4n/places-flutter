import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function selectImage;

  ImageInput(this.selectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) return;

    setState(() {
      _storedImage = imageFile;
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');

    widget.selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          alignment: Alignment.center,
          child: Card(
            child: _storedImage != null
                ? Image.file(
                    this._storedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Text('No image selected'),
          ),
        ),
        FlatButton.icon(
          icon: Icon(Icons.camera),
          label: Text('Take Picture'),
          textColor: Theme.of(context).accentColor,
          onPressed: this._takePicture,
        )
      ],
    );
  }
}
