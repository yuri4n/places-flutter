import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File image) {
    _pickedImage = image;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) return;

    Provider.of<Places>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(this._selectImage),
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaisedButton.icon(
                color: Theme.of(context).accentColor,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  'Add place',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: this._savePlace,
              ),
              if (Platform.isIOS)
                SizedBox(
                  height: 25,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
