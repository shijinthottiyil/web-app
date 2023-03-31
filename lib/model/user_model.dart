import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String age;
  final String batchNum;
  final String course;
  final String docId;

  UserModel({
    required this.name,
    required this.age,
    required this.batchNum,
    required this.course,
    required this.docId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'batchNum': batchNum,
      'course': course,
      'docId': docId,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      name: snap['name'],
      age: snap['age'],
      batchNum: snap['batchNum'],
      course: snap['course'],
      docId: snap['docId'],
    );
  }
}
