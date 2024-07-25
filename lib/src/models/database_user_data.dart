// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:catatan_sehat_ku/src/models/blood_pressure_model.dart';
import 'package:catatan_sehat_ku/src/models/cholesterol_model.dart';
import 'package:catatan_sehat_ku/src/models/memory_test_record.dart';
import 'package:catatan_sehat_ku/src/models/sleep_record_model.dart';
import 'package:catatan_sehat_ku/src/models/weight_record_model.dart';

class DatabaseUserData {
  final String uid;
  final UserProfile profile;
  final UserData data;

  const DatabaseUserData({required this.uid, required this.profile, required this.data});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'profile': profile.toMap(),
      'data': data.toMap(),
    };
  }

  factory DatabaseUserData.fromMap(Map<String, dynamic> map) {
    return DatabaseUserData(
      uid: map['uid'] as String,
      profile: UserProfile.fromMap(map['profile'] as Map<String, dynamic>),
      data: UserData.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DatabaseUserData.fromJson(String source) => DatabaseUserData.fromMap(json.decode(source) as Map<String, dynamic>);

  DatabaseUserData copyWith({
    String? uid,
    UserProfile? profile,
    UserData? data,
  }) {
    return DatabaseUserData(
      uid: uid ?? this.uid,
      profile: profile ?? this.profile,
      data: data ?? this.data,
    );
  }
}

class UserProfile {
  final String name;
  final String email;
  final String photo;
  final String theme;

  const UserProfile({required this.name, required this.email, required this.photo, required this.theme});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'photo': photo,
      'theme': theme,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] as String,
      email: map['email'] as String,
      photo: map['photo'] as String,
      theme: map['theme'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) => UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  UserProfile copyWith({
    String? name,
    String? email,
    String? photo,
    String? theme,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      theme: theme ?? this.theme,
    );
  }
}

class UserData {
  final List<WeightRecordModel> weight;
  final List<BloodPressureRecordModel> blood;
  final List<SleepRecordModel> sleep;
  final List<CholesterolRecordModel> cholesterol;
  final List<MemoryTestRecordModel> memory;

  const UserData({required this.weight, required this.blood, required this.sleep, required this.cholesterol, required this.memory});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weight': weight.map((x) => x.toMap()).toList(),
      'blood': blood.map((x) => x.toMap()).toList(),
      'sleep': sleep.map((x) => x.toMap()).toList(),
      'cholesterol': cholesterol.map((x) => x.toMap()).toList(),
      'memory': memory.map((x) => x.toMap()).toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      weight: List<WeightRecordModel>.from(
        (map['weight'] as List<int>).map<WeightRecordModel>(
          (x) => WeightRecordModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      blood: List<BloodPressureRecordModel>.from(
        (map['blood'] as List<int>).map<BloodPressureRecordModel>(
          (x) => BloodPressureRecordModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      sleep: List<SleepRecordModel>.from(
        (map['sleep'] as List<int>).map<SleepRecordModel>(
          (x) => SleepRecordModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      cholesterol: List<CholesterolRecordModel>.from(
        (map['cholesterol'] as List<int>).map<CholesterolRecordModel>(
          (x) => CholesterolRecordModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      memory: List<MemoryTestRecordModel>.from(
        (map['memory'] as List<int>).map<MemoryTestRecordModel>(
          (x) => MemoryTestRecordModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  UserData copyWith({
    List<WeightRecordModel>? weight,
    List<BloodPressureRecordModel>? blood,
    List<SleepRecordModel>? sleep,
    List<CholesterolRecordModel>? cholesterol,
    List<MemoryTestRecordModel>? memory,
  }) {
    return UserData(
      weight: weight ?? this.weight,
      blood: blood ?? this.blood,
      sleep: sleep ?? this.sleep,
      cholesterol: cholesterol ?? this.cholesterol,
      memory: memory ?? this.memory,
    );
  }
}
