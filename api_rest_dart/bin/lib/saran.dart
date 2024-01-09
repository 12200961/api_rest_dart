// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';
// import 'controller.dart';

class Saran {
  final int id;
  final String? isi_saran;
  final int? iduser;
  String? tanggal_input;
  String? tanggal_update;

  Saran({
    required this.id,
    required this.isi_saran,
    required this.iduser,
    required this.tanggal_input,
    required this.tanggal_update,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'isi_saran': isi_saran,
        'iduser': iduser,
        'tanggal_input': tanggal_input,
        'tanggal_update': tanggal_update
      };

  // final Controller ctrl = Controller();

  factory Saran.fromJson(Map<String, dynamic> json) => Saran(
        id: json['id'],
        isi_saran: json['isi_saran'],
        iduser: json['iduser'],
        tanggal_input: json['tanggal_input'],
        tanggal_update: json['tanggal_update'],
      );
}

Saran saranFromJson(String str) => Saran.fromJson(json.decode(str));
