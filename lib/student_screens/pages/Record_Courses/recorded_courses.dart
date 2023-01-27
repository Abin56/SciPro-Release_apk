// ignore_for_file: unnecessary_string_interpolations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/live_course_model.dart';
import '../../../widgets/button_Container.dart';
import 'new_rec_course_details.dart';

var arec_CourseID = "";

class RecordedCoursesListScreen extends StatelessWidget {
  String name = "";
  String courseid = "";

  RecordedCoursesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 44, 59),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Select your plan'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('RecordedCourselist')
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final data = LiveCourseAddModel.fromJson(
                            snapshots.data!.docs[index].data());

                        return Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await Get.to(RecordedCourseDetailScreen(
                                    id: data.id,
                                    coursetitle: data.courseTitle,
                                    faculty: data.facultyName,
                                    coursefee: data.courseFee,
                                    duration: data.duration,
                                    courseId: data.courseID,
                                    date: data.postedDate,
                                    time: data.postedTime));
                              },
                              child: ButtonContainerWidget(
                                curving: 30,
                                colorindex: 0,
                                height: 200,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${data.courseTitle}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Text(
                                      'Duration : ${data.duration} days ',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      '${data.courseFee.toString() + ' /- (inc.of all taxess)'}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20.h,
                        );
                      },
                      itemCount: snapshots.data!.docs.length),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
    );
  }
}
