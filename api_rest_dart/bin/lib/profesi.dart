// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';
// import 'controller.dart';

class Profesi {
  final int? profesi_id;
  final String? profesi;

  Profesi({required this.profesi_id, required this.profesi});

  Map<String, dynamic> toMap() =>
      {'profesi_id': profesi_id, 'profesi': profesi};

  // final Controller ctrl = Controller();

  factory Profesi.fromJson(Map<String, dynamic> json) =>
      Profesi(profesi_id: json['profesi_id'], profesi: json['profesi']);
}

Profesi profesiFromJson(String str) => Profesi.fromJson(json.decode(str));
