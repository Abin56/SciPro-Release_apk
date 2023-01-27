import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scipro_app/controllers/s_m_Controllers.dart';
import 'package:scipro_app/student_screens/pages/Study_Materials/pDF_viewer.dart';
import 'package:scipro_app/widgets/button_Container.dart';

import '../../../model/studyMaterials.dart/s_materials_model.dart';

class AllStudyMaterialScreen extends StatefulWidget {
  var catData;
  var courseCategory;
  AllStudyMaterialScreen(
      {required this.catData, required this.courseCategory, super.key});

  @override
  State<AllStudyMaterialScreen> createState() => _AllStudyMaterialScreenState();
}

class _AllStudyMaterialScreenState extends State<AllStudyMaterialScreen> {
  final getxController = Get.put(StudyMaterialController());

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 3;

    return Scaffold(
        appBar: AppBar(
            title: const Text("Study Materials"),
            centerTitle: true,
            brightness: Brightness.dark),
        body: GetBuilder<StudyMaterialController>(
          init: getxController,
          initState: (_) {},
          builder: (_) {
            return getxController.list1.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : StreamBuilder(
                    stream: getxController.getProduct(widget.catData),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<StudyMaterialModel>> snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                print("calinng files${data.studymaterialFile}");
                                return ButtonContainerWidget(
                                  curving: 20,
                                  colorindex: 0,
                                  height: 200,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Subject  :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data.subject,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Sub Title  :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data.subtitle,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Category  :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              widget.courseCategory,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Files  :",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                // Get.to(PDfReaderscreen(
                                                //     fileMaterial: data
                                                //         .studymaterialFile)
                                                //         );
                                                // Get.to(PDFSectionScreen(
                                                //   urlPdf:
                                                //       data.studymaterialFile,
                                                // ));
                                                await Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) {
                                                    return PDFSectionScreen(
                                                        urlPdf: data
                                                            .studymaterialFile);
                                                  },
                                                ));
                                              },
                                              child: ButtonContainerWidget(
                                                curving: 30,
                                                colorindex: 0,
                                                height: 30,
                                                width: 80,
                                                child: const Center(
                                                  child: Text(
                                                    "Get",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: snapshot.data!.length),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                    });
          },
        ));
  }
}


// import this Package in pubspec.yaml file
// dependencies:
// 
// flutter_staggered_animations: 



