import 'package:flutter/material.dart';

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
                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                    hintText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 5),

                TextFormField(
                  controller: productDescriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Product Description',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 5),

                TextFormField(
                  controller: productPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Product Price (in Rs.)',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 5),

                TextFormField(
                  controller: productQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Product Quantity',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 5),

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
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      print(productNameController.text);
                      print(productDescriptionController.text);
                      print(productPriceController.text);
                      print(productQuantityController.text);
                      print(selectedCategory);
                    },
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