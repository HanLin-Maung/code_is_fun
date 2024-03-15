import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_education/Api/api.dart';
import 'package:mobile_education/screens/featured_screen.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;
  // File? _image;

  // final picker = ImagePicker();

  // Future<void> getImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // void addCategory(){
  //   String title = _titleController.text;
  //   String description = _descriptionController.text;

  //   if (title.isNotEmpty && description.isNotEmpty){
  //     Navigator.pop(context, {"title": title, "description": description});
  //   } else{
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: const SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text("Please fill out all fields."),
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () {Navigator.of(context).pop();},

  //               child:const Text("OK"),
  //             )
  //           ]
  //         );
  //       },
  //     );

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GestureDetector(
              //   onTap: (){getImage();},
              //   child: _image == null
              //   ? Container(
              //     width: double.infinity,
              //     height: 150,
              //     color: Colors.grey.shade200,
              //     child: const Center(
              //       child: Icon(Icons.add_a_photo),
              //     ),
              //   )
              //   : Image.file(
              //     _image!,
              //     width: double.infinity,
              //     height: 150,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // const SizedBox(height: 20,),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  createCategory();
                  setState(() {});
                },
                height: 50,
                color: Colors.blueGrey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: isLoading
                      ? const SpinKitRing(
                          color: Colors.white,
                          size: 30,
                          lineWidth: 2,
                        )
                      : const Text(
                          "Add Category",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              )
              // ElevatedButton(
              //   onPressed: (){
              //    createCategory();
              //   },
              //   child: const Text(
              //     "Add Category",
              //     style: TextStyle(),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  createCategory() async {
    final response = await API().createCategoryApi(
      _titleController.text,
      _descriptionController.text,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(
        ">>>>>>>>>>> create category response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> create category response body ${response.body}");
    if (response.statusCode == 201) {
      print("herer 0--");
      if (res['success'] == true) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FeaturedScreen(),
          ),
        );
      }
    } else if (response.statusCode == 400) {
      // showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }
}


//                               child: Column(
//                                 children: <Widget>[
//                                   Container(
//                                     padding: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       border: Border(
//                                         bottom: BorderSide(
//                                             color: Colors.grey.shade200),
//                                       ),
//                                     ),
//                                     child: TextField(
//                                       controller: _emailController,
//                                       obscureText: false,
//                                       decoration: const InputDecoration(
//                                         hintText: 'Email',
//                                         hintStyle: TextStyle(color: Colors.grey),
//                                         border: InputBorder.none,
//                                         prefixIcon: Icon(Icons.email),
                                        
//                                       ),
//                                       keyboardType: TextInputType.emailAddress,
//                                       autocorrect: false,
//                                       textCapitalization: TextCapitalization.none,
//                                       // validator: (value) {
//                                       //   if (value == null || value.isEmpty) {
//                                       //     return "Please enter your email address.";
//                                       //   }
//                                       //   return null;
//                                       // },
//                                       // onSaved: () {
                                        
//                                       // }
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       border: Border(
//                                         bottom: BorderSide(
//                                             color: Colors.grey.shade200),
//                                       ),
//                                     ),
//                                     child: TextField(
//                                       controller: _passwordController,
//                                       obscureText: _isHidden,
//                                       decoration: InputDecoration(
//                                           hintText: 'Password',
//                                           hintStyle:
//                                               TextStyle(color: Colors.grey),
//                                           border: InputBorder.none,
//                                           prefixIcon: Icon(Icons.password),
//                                           suffixIcon: IconButton(
//                                             icon: Icon(_isHidden
//                                                 ? Icons.visibility_off
//                                                 : Icons.visibility),
//                                             onPressed: () {
//                                               setState(() {
//                                                 _isHidden = !_isHidden;
//                                               });
//                                             },
//                                           )),
//                                     ),
//                                   )
//                                 ],
//                               ),