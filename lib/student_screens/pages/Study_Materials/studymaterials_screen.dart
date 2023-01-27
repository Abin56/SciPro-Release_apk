import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scipro_app/model/studyMaterials.dart/s_materials_model.dart';
import 'package:scipro_app/student_screens/pages/Study_Materials/AllStudy_materials.dart';
import 'package:scipro_app/widgets/button_Container.dart';

import '../../../model/studyMaterials.dart/s_m_cat_model.dart';

class StudentStudyMaterialsScreen extends StatelessWidget {
  const StudentStudyMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;

    return Scaffold(
      appBar: AppBar(
        title: Text("All Category"),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("CategoryS_Material")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AnimationLimiter(
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.all(_w / 60),
                      crossAxisCount: columnCount,
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (int index) {
                          final data = StudyMateriCategoryModel.fromJson(
                              snapshot.data!.docs[index].data());
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 200),
                            columnCount: columnCount,
                            child: ScaleAnimation(
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return AllStudyMaterialScreen(
                                            courseCategory: data.courseTitle,
                                            catData: data.courseTitle,
                                          );
                                        },
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ButtonContainerWidget(
                                          curving: 30,
                                          colorindex: 3,
                                          height: 100,
                                          width: 200,
                                          child: Center(
                                            child: Text(
                                              data.courseTitle,
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )),
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
              })),
    );
  }
}
