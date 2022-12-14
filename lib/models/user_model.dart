import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? gender;
  String? region;
  bool isVerified;

  UserModel({
    required this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.region,
    this.isVerified = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "region": region,
      "isVerified": isVerified,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : userId = doc.id,
        email = doc.data()!["email"],
        firstName = doc.data()!["firstName"],
        lastName = doc.data()!["lastName"],
        dateOfBirth = doc.data()!["dateOfBirth"],
        gender = doc.data()!["gender"],
        region = doc.data()!["region"],
        isVerified = doc.data()!["isVerified"];

  UserModel copyWith(
      {String? userId,
      String? email,
      String? firstName,
      String? lastName,
      String? dateOfBirth,
      String? gender,
      String? region,
      bool? isVerified}) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      region: region ?? this.region,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
