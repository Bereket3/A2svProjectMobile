import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/product_model.dart';
import '../bloc/product_bloc.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  File? selectedImage;

  Future<void> pickImageFromGallery() async {
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
  TextEditingController catagoryController = TextEditingController();
  TextEditingController massageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic product = ModalRoute.of(context)!.settings.arguments;
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
        title: const Text('Update Product'),
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
                  child: selectedImage == null
                      ? Image.network(
                          product.imageUrl!,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        )
                      : Image.file(
                          selectedImage!,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('name'),
                const SizedBox(
                  height: 7,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: product.name,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                    //labelText: 'name',
                    fillColor: const Color(0xFFF3F3F3),
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
                const SizedBox(
                  height: 7,
                ),
                const Text('catagory'),
                const SizedBox(
                  height: 7,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: catagoryController,
                  decoration: InputDecoration(
                    hintText: product.name,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                    //labelText: 'name',
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                const Text('price'),
                const SizedBox(
                  height: 7,
                ),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: product.price.toString(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                    //labelText: 'name',
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                const Text('description'),
                const SizedBox(
                  height: 7,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  maxLines: 5,
                  controller: massageController,
                  decoration: InputDecoration(
                    hintText: product.description,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                    //labelText: 'name',
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                TextButton(
                  onPressed: () => {
                    if (_formKey.currentState!.validate()) {},
                    BlocProvider.of<ProductBloc>(context)
                      .add(UpdateProductEvent(
                        product: ProductModel(
                          id: product.id,
                          name: nameController.text,
                          description: massageController.text,
                          price: int.parse(priceController.text).toDouble(),
                          imageUrl: selectedImage!.path
                        ),
                      )
                    ),
                    Navigator.pop(context),
                  },
                  style: TextButton.styleFrom(
                    elevation: 2,
                    backgroundColor: const Color.fromARGB(255, 11, 120, 210),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    fixedSize:
                        const Size.fromWidth(340.0), // Button width and height
                  ),
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 234, 46, 33)),
                    elevation: 2,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fixedSize:
                        const Size.fromWidth(340.0), // Button width and height
                  ),
                  child: const Text(
                    'DELETE',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
