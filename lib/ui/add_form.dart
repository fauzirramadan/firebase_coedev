import 'package:firebase_coedev/controller/add_data.dart';
import 'package:flutter/material.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  AddDataController controller = AddDataController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: const Text("ADD YOUR FOOD"),
      ),
      body: Form(
        key: keyForm,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.yellow,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.foodNameC,
                        validator: (value) {
                          return controller.foodNameC.value.text.isEmpty
                              ? "Cannot be empty"
                              : null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            hintText: "Food Name",
                            fillColor: Colors.black.withOpacity(0.2),
                            filled: true),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.priceC,
                        validator: (value) {
                          return controller.priceC.value.text.isEmpty
                              ? "Cannot be empty"
                              : null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            hintText: "Price",
                            fillColor: Colors.black.withOpacity(0.2),
                            filled: true),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.stockC,
                        validator: (value) {
                          return controller.stockC.value.text.isEmpty
                              ? "Cannot be empty"
                              : null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            hintText: "Stock",
                            fillColor: Colors.black.withOpacity(0.2),
                            filled: true),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        minWidth: double.infinity,
                        onPressed: () {
                          if (keyForm.currentState!.validate()) {
                            controller.addDataFood(
                                controller.foodNameC.text,
                                controller.priceC.text,
                                controller.stockC.text,
                                context);
                          }
                        },
                        height: 50,
                        color: Colors.yellow[200],
                        child: const Text("SUBMIT"),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
