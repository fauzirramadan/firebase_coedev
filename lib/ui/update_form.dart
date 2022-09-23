import 'package:firebase_coedev/controller/update_data.dart';
import 'package:flutter/material.dart';

class UpdateForm extends StatefulWidget {
  final String id;
  final dynamic data;
  const UpdateForm({super.key, required this.id, required this.data});

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  // update controller
  UpdateData controller = UpdateData();

  @override
  void dispose() {
    controller.foodNameC.dispose();
    controller.priceC.dispose();
    controller.stockC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.foodNameC.text = widget.data["name"];
    controller.priceC.text = widget.data["price"];
    controller.stockC.text = widget.data["stock"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: const Text("UPDATE YOUR FOOD"),
      ),
      body: ListView(
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
                        controller.updateFood(
                            widget.id,
                            controller.foodNameC.text,
                            controller.priceC.text,
                            controller.stockC.text,
                            context);
                      },
                      height: 50,
                      color: Colors.yellow[200],
                      child: const Text("UPDATE"),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
