// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';
// import 'controller.dart';

class Role {
  final int? role_id;
  final String? role;

  Role({required this.role_id, required this.role});

  Map<String, dynamic> toMap() => {'role_id': role_id, 'role': role};

  // final Controller ctrl = Controller();

  factory Role.fromJson(Map<String, dynamic> json) =>
      Role(role_id: json['role_id'], role: json['role']);
}

Role roleFromJson(String str) => Role.fromJson(json.decode(str));
