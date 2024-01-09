// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';
// import 'controller.dart';

class Motivasi {
  final int id;
  final String? isi_motivasi;
  final int? iduser;
  String? tanggal_input;
  String? tanggal_update;

  Motivasi({
    required this.id,
    required this.isi_motivasi,
    required this.iduser,
    required this.tanggal_input,
    required this.tanggal_update,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'isi_motivasi': isi_motivasi,
        'iduser': iduser,
        'tanggal_input': tanggal_input,
        'tanggal_update': tanggal_update
      };

  // final Controller ctrl = Controller();

  factory Motivasi.fromJson(Map<String, dynamic> json) => Motivasi(
        id: json['id'],
        isi_motivasi: json['isi_motivasi'],
        iduser: json['iduser'],
        tanggal_input: json['tanggal_input'],
        tanggal_update: json['tanggal_update'],
      );
}

Motivasi motivasiFromJson(String str) => Motivasi.fromJson(json.decode(str));
