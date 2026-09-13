import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  static const String routeName = '/add-product';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productQuantityController = TextEditingController();

  List<String> categories = [
    'Mobiles',
    'Laptops',
    'Cameras',
    'Books',
    'Fashion',
  ];

  String selectedCategory = 'Mobiles';

  final List<File> _images = [];

  Future<void> _getImage() async {
    if (_images.length >= 6) {
      return;
    }

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text(
            "Add Product",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.lightBlueAccent,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            child: Column(
              children: [
                // Image section
                if (_images.isEmpty)
                  GestureDetector(
                    onTap: _getImage,
                    child: DottedBorder(
                      options: const RoundedRectDottedBorderOptions(
                        dashPattern: [10, 4],
                        strokeCap: StrokeCap.round,
                        strokeWidth: 1.5,
                        radius: Radius.circular(10),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder_open,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Add Product Images',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Maximum 6 images',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount: _images.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(
                                      _images[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Remove image
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _images.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                        const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      // Add more images
                      if (_images.length < 6)
                        GestureDetector(
                          onTap: _getImage,
                          child: DottedBorder(
                            options: const RoundedRectDottedBorderOptions(
                              dashPattern: [10, 4],
                              strokeCap: StrokeCap.round,
                              strokeWidth: 1.5,
                              radius: Radius.circular(10),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 8),
                                  Text(
                                    'Add More Images',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                const SizedBox(height: 15),

                // Product name
                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                    hintText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 5),

                // Product description
                TextFormField(
                  controller: productDescriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Product Description',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 5),

                // Product price
                TextFormField(
                  controller: productPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Product Price (in Rs.)',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 5),

                // Product quantity
                TextFormField(
                  controller: productQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Product Quantity',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 5),

                // Category
                Align(
                  alignment: Alignment.centerLeft,
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),

                const SizedBox(height: 15),

                // Add Product button
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'Add Product',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}