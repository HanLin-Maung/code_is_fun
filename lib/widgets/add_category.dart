import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  

  void addCategory(){
    String title = _titleController.text;
    String description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty){
      Navigator.pop(context, {"title": title, "description": description});
    } else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Please fill out all fields."),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {Navigator.of(context).pop();},
                
                child:const Text("OK"),
              )
            ]
          );
        },
      );
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){getImage();},
              child: _image == null
              ? Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey.shade200,
                child: Center(
                  child: Icon(Icons.add_a_photo),
                ),
              )
              : Image.file(
                _image!,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _titleController,
              decoration:const InputDecoration(
                labelText: "Title",
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description'
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (){
                addCategory();
              },
              child: const Text("Add Category"),
            )
          ],
        ),
      ),
    );
  }


}
