import 'package:flutter/material.dart';
import 'dart:core'; 
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_application_1/pages/add_product.dart';


class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key});

  @override
  State<UpdateProduct> createState() => _UpdateProduct();
  
}

class _UpdateProduct extends State<UpdateProduct> {
  File? selectedImage;

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (returnedImage != null) {
        selectedImage = File(returnedImage.path);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String price = '';
  TextEditingController catagoryController = TextEditingController();
  TextEditingController massageController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    // dynamic product = ModalRoute.of(context)?.settings.arguments;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.blue,
            size: 25,
          ),
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
          ),
        ),
        title: const Text("Update Product"),
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImageFromGallery();
                  },
                  child: selectedImage == null ? Container(
                    height: 200,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('upload image', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ): Image.file(
                    selectedImage!,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ),
                const SizedBox(height: 10,),
                const Text("name"),
                const SizedBox(height: 7,),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      )
                    ),
                    //labelText: 'name',
                    fillColor:const Color(0xFFF3F3F3),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7,),
                const Text("catagory"),
                const SizedBox(height: 7,),
                TextFormField(
                  controller: catagoryController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      )
                    ),
                    //labelText: 'name',
                    fillColor:const Color(0xFFF3F3F3),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7,),
                const Text("price"),
                const SizedBox(height: 7,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() {
                    price = val;
                  }),
                  controller: priceController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      )
                    ),
                    //labelText: 'name',
                    fillColor:const Color(0xFFF3F3F3),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7,),
                const Text("description"),
                const SizedBox(height: 7,),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      )
                    ),
                    //labelText: 'name',
                    fillColor:const Color(0xFFF3F3F3),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7,),
                TextButton(
                  onPressed: () => {
                    if (selectedImage == null) {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context, 
                        builder: (context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Text(
                                "You didn't select any image",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          );
                        }
                      )
                    }else {
                      if (_formKey.currentState!.validate()) {},
                      Navigator.pop(context, 
                        Product(
                          catagory: catagoryController.text, 
                          name: nameController.text, 
                          price: price, 
                          description: massageController.text,
                          image: selectedImage,
                        )
                      ),
                    },
                  },
                  style: TextButton.styleFrom(
                      elevation: 2,
                      backgroundColor: const Color.fromARGB(255, 11, 120, 210),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      fixedSize:const Size.fromWidth(340.0), // Button width and height
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                    ),
                  ),
                ),
                const SizedBox(height: 7,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}