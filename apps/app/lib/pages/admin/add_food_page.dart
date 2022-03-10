import 'dart:async';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:zomateen/providers/food_item_provider.dart';

class AddFoodpage extends StatefulWidget {
  const AddFoodpage({Key? key}) : super(key: key);

  @override
  State<AddFoodpage> createState() => _AddFoodpageState();
}

class _AddFoodpageState extends State<AddFoodpage> {
  bool loading = false;
  String? picPath;
  String? imgName;
  PlatformFile? uploadedFile;

  void getPic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;

      setState(() {
        imgName = file.name;
      });

      uploadedFile = file;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final _foodProvider = Provider.of<FoodItemProvider>(context);

    late String _name;
    late int _price;

    void _saveForm() async {
      setState(() {
        loading = true;
      });

      final bool isValid = _formKey.currentState!.validate();

      if (isValid) {
        if (imgName == null || uploadedFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Pick an Image",
                style: TextStyle(color: Colors.black),
              ),
            ),
          );

          return;
        }

        _formKey.currentState!.save();
      }

      bool res =
          await _foodProvider.add_food_item(_name, _price, uploadedFile!);

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Food Item Added successfully",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );

      Timer(const Duration(seconds: 2),
          () => {if (res) Navigator.of(context).pop()});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Food"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              imgName != null ? Text(imgName!) : const Text("Pick an Image"),
              IconButton(
                onPressed: () => getPic(),
                icon: const Icon(Icons.add_a_photo),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (loading)
                      LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    TextFormField(
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      onSaved: (val) {
                        if (val != null) _name = val;
                      },
                      validator: (val) =>
                          (val == null) ? "Enter a valid name" : null,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.mail),
                        labelText: 'Food Name',
                        helperText: 'Enter the Food Item Name',
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    TextFormField(
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      onSaved: (val) {
                        if (val != null) _price = int.parse(val);
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      validator: (val) {
                        if (val == null || double.tryParse(val) == null) {
                          return "Enter a valid Price";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.password),
                        labelText: 'Price',
                        helperText: 'Enter the Food Item Price',
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: const Text("Add Food item"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
