import 'dart:convert';

import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final DateTime dateJoined;
  final String photoProfileBase64;

  const AccountModel({required this.id, required this.name, required this.email, required this.dateJoined, required this.photoProfileBase64});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'dateJoined': dateJoined.millisecondsSinceEpoch,
      'photoProfileBase64': photoProfileBase64,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      dateJoined: DateTime.fromMillisecondsSinceEpoch(map['dateJoined'] as int),
      photoProfileBase64: map['photoProfileBase64'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) => AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AccountModel copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? dateJoined,
    String? photoProfileBase64,
  }) {
    return AccountModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      dateJoined: dateJoined ?? this.dateJoined,
      photoProfileBase64: photoProfileBase64 ?? this.photoProfileBase64,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      dateJoined,
      photoProfileBase64,
    ];
  }
}
