import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_coedev/auth/auth.dart';
import 'package:firebase_coedev/controller/get_data.dart';
import 'package:firebase_coedev/ui/add_form.dart';
import 'package:firebase_coedev/ui/update_form.dart';
import 'package:firebase_coedev/utils/my_alert.dart';
import 'package:firebase_coedev/utils/shimmer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth auth = Auth();

  // controller get data
  GetDataController controller = GetDataController();

  // alert
  MyAlertDialog alert = MyAlertDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(elevation: 0, title: const Text("Foodie"), actions: [
        IconButton(
            onPressed: () {
              auth.logoutUser(context);
            },
            icon: const Icon(Icons.logout_outlined))
      ]),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.getData(),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.separated(
                  itemBuilder: (context, index) => const ShimmerLoading(),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: 7);
            }
            if (snapshot.data!.size == 0) {
              return const Center(
                child: Text(
                  "NO DATA",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                      color: Colors.yellow,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 0),
                        child: ListTile(
                          title: Text(data[index]["name"]),
                          subtitle: Text(
                            "price : RM${data[index]["price"]}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: SizedBox(
                            width: 90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                    child: Text(
                                  data[index]["stock"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                IconButton(
                                  onPressed: () {
                                    alert.myAlertDialog(
                                      context,
                                      "Are you sure to delete this data?",
                                      TextButton(
                                        onPressed: () {
                                          controller.deleteFood(
                                              data[index].id, context);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "DELETE",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                          leading: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UpdateForm(
                                    id: data[index].id,
                                    data: data[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.yellow,
            height: 55,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AddForm())),
            child: const Text("ADD FOOD"),
          )),
    );
  }
}
