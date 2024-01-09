// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';
// import 'controller.dart';

class User {
  final int? iduser;
  final String? nama;
  final Int? id_profesi;
  final String? email;
  final String? password;
  final int? role_id;
  final int? is_active;
  String? tanggal_input;
  String? modified;

  User({
    required this.iduser,
    required this.nama,
    required this.id_profesi,
    required this.email,
    required this.password,
    required this.role_id,
    required this.is_active,
    required this.tanggal_input,
    required this.modified,
  });

  Map<String, dynamic> toMap() => {
        'iduser': iduser,
        'nama': nama,
        'id_profesi': id_profesi,
        'email': email,
        'password': password,
        'role_id': role_id,
        'is_active': is_active,
        'tanggal_input': tanggal_input,
        'modified': modified
      };

  // final Controller ctrl = Controller();

  factory User.fromJson(Map<String, dynamic> json) => User(
        iduser: json['iduser'],
        nama: json['nama'],
        id_profesi: json['id_profesi'],
        email: json['email'],
        password: json['password'],
        role_id: json['role_id'],
        is_active: 1,
        tanggal_input: json['tanggal_input'],
        modified: json['modified'],
      );
}

User userFromJson(String str) => User.fromJson(json.decode(str));
