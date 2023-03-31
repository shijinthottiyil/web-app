// import 'dart:developer';

// import 'package:firebase_app/controller/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Consumer<HomeController>(
//       builder: (context, value, child) => Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(
//                         'https://th.bing.com/th/id/R.916e699b606fe1368fcde3316cd4661e?rik=kQQtgHOUAgKGlw&riu=http%3a%2f%2fgetwallpapers.com%2fwallpaper%2ffull%2f1%2f9%2fc%2f432258.jpg&ehk=P5TLyd21rtR%2ffnXKiDT65eTzF2ylPEISNAT2CyRpZOo%3d&risl=&pid=ImgRaw&r=0'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Container(
//                     height: height / 4,
//                     width: width,
//                     // color: Colors.red,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         'NAME',
//                         style: GoogleFonts.ubuntuCondensed(
//                           fontSize: 40,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       width: width,
//                       // color: Colors.blue,
//                       child: Center(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           width: width / 5,
//                           height: height / 10,
//                           child: GestureDetector(
//                             onTap: () async {
//                               log('ontapppppppppppppppppppppppppp');
//                               await value.googleSignIn();
//                             },
//                             child: Center(
//                               child: value.isLoading
//                                   ? CircularProgressIndicator(
//                                       color: Colors.red,
//                                     )
//                                   : Text(
//                                       'continue with google',
//                                       style: GoogleFonts.ubuntuCondensed(
//                                         color: Colors.black,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/controller/home_controller.dart';
import 'package:firebase_app/model/user_model.dart';
import 'package:firebase_app/view/screen/search_delegate.dart';
import 'package:firebase_app/view/widgets/home/alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _batchController = TextEditingController();
  TextEditingController _courseController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _batchController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  Future<void> getUserData({required String docId}) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(docId).get();
    var data = docSnapshot;
    _nameController = TextEditingController(text: data['name']);
    _ageController = TextEditingController(text: data['age']);
    _batchController = TextEditingController(text: data['batchNum']);
    _courseController = TextEditingController(text: data['course']);
    log(data['name']);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('name', descending: false)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data();
                    var docId = data['docId'];
                    return ListTile(
                      title: Text(data['name']),
                      subtitle: Text(data['batchNum']),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Delete Confirmation"),
                                content: Text(
                                    "Are you sure you want to delete this item?"),
                                actions: [
                                  TextButton(
                                    child: Text("Delete"),
                                    onPressed: () async {
                                      // Perform delete operation here
                                      await value.deleteData(docId);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                      onTap: () async {
                        await getUserData(docId: docId);
                        // await getUserData(
                        //     docId: data['name'] + data['batchNum']);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialogWidget(
                              nameController: _nameController,
                              ageController: _ageController,
                              batchController: _batchController,
                              courseController: _courseController,
                              mainName: " Details",
                              buttonName: 'Update',
                              isLoad: value.isLoading,
                              onTapFn: () async {
                                UserModel user = UserModel(
                                    docId: data['docId'],
                                    name: _nameController.text,
                                    age: _ageController.text,
                                    batchNum: _batchController.text,
                                    course: _courseController.text);
                                await value.updateData(docId, user);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                log(snapshot.error.toString());
              }
            }
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                return Text(index.toString());
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _nameController.clear();
            _ageController.clear();
            _batchController.clear();
            _courseController.clear();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialogWidget(
                  nameController: _nameController,
                  ageController: _ageController,
                  batchController: _batchController,
                  courseController: _courseController,
                  mainName: "Enter Details",
                  buttonName: 'Save',
                  isLoad: value.isLoading,
                  onTapFn: () async {
                    await value.storeData(
                      _nameController.text,
                      _ageController.text,
                      _batchController.text,
                      _courseController.text,
                    );
                    _nameController.clear();
                    _ageController.clear();
                    _batchController.clear();
                    _courseController.clear();

                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
