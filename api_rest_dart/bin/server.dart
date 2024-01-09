// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:intl/intl.dart';

import 'lib/user.dart';
import 'lib/motivasi.dart';
import 'lib/saran.dart';
import 'lib/role.dart';
import 'lib/profesi.dart';

// Configure routes.
final _router = Router()

  //USER
  ..get('/user', _connectSqlHandlerUser)
  ..get('/userFilter', _handlerUserFilter)
  ..post('/postUserData', postUserData)
  ..put('/putUpdateUser', putUserData)
  ..delete('/deleteUser', deleteUser)
  //ROLE
  ..get('/role', _connectSqlHandlerRole)
  ..get('/roleFilter', _handlerRoleFilter)
  ..post('/postRoleData', postRoleData)
  ..put('/putUpdateRole', putRoleData)
  ..delete('/deleteRole', deleteRole)
  //PROFESI
  ..get('/profesi', _connectSqlHandlerProfesi)
  ..get('/profesiFilter', _handlerProfesiFilter)
  ..post('/postProfesiData', postProfesiData)
  ..put('/putUpdateProfesi', putProfesiData)
  ..delete('/deleteProfesi', deleteProfesi)
  //MOTIVASI
  ..get('/motivasi', _connectSqlHandlerMotivasi)
  ..get('/motivasiFilter', _handlerMotivasiFilter)
  ..post('/postMotivasiData', postMotivasiData)
  ..put('/putUpdateMotivasi', putMotivasiData)
  ..delete('/deleteMotivasi', deleteMotivasi)
  //SARAN
  ..get('/saran', _connectSqlHandlerSaran)
  ..get('/saranFilter', _handlerSaranFilter)
  ..post('/postSaranData', postSaranData)
  ..put('/putUpdateSaran', putSaranData)
  ..delete('/deleteSaran', deleteSaran);

String getDateNow() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
  final String dateNow = formatter.format(now);
  return dateNow;
}

Future<MySqlConnection> _ConnectSql() async {
  var settings = ConnectionSettings(
      host: '127.0.0.1', port: 3306, user: 'root', db: 'api_web_rest');
  var cn = await MySqlConnection.connect(settings);
  return cn;
}

/* USER */
Future<Response> _connectSqlHandlerUser(Request request) async {
  var conn = await _ConnectSql();
  var users = await conn.query('SELECT * FROM user', []);
  return Response.ok(users.toString());
}

Future<Response> _handlerUserFilter(Request request) async {
  String body = await request.readAsString();
  var obj = json.decode(body);
  var name = "%" + obj['nama'] + "%";

  var conn = await _ConnectSql();
  var users = await conn.query('SELECT * FROM user where nama like ? ', [name]);

  return Response.ok(users.toString());
}

Future<Response> postUserData(Request request) async {
  String body = await request.readAsString();
  User user = userFromJson(body);
  user.tanggal_input = getDateNow();
  user.modified = getDateNow();

  var conn = await _ConnectSql();
  var sqlExecute = """
      INSERT INTO user (iduser, nama, id_profesi, email, password, role_id, is_active, tanggal_input, modified)
      VALUES ('${user.iduser}', '${user.nama}', '${user.id_profesi}', '${user.email}', '${user.password}', '${user.role_id}', '${user.is_active}', '${user.tanggal_input}', '${user.modified}')
      """;
  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM USER WHERE nama = ?";
  var userResponse = await conn.query(sql, [user.nama]);

  return Response.ok(userResponse.toString());
}

Future<Response> putUserData(Request request) async {
  String body = await request.readAsString();
  User user = userFromJson(body);
  user.modified = getDateNow();

  var conn = await _ConnectSql();
  var sqlExecute = """
      UPDATE user SET
                  nama = '${user.nama}', 
                  id_profesi = '${user.id_profesi}', 
                  email = '${user.email}', 
                  password = '${user.password}', 
                  role_id = '${user.role_id}', 
                  modified = '${user.modified}'
      WHERE iduser = '${user.iduser}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM USER WHERE iduser = ?";
  var userResponse = await conn.query(sql, [user.iduser]);

  return Response.ok(userResponse.toString());
}

Future<Response> deleteUser(Request request) async {
  String body = await request.readAsString();
  User user = userFromJson(body);

  var conn = await _ConnectSql();
  var sqlExecute = """
      DELETE FROM USER WHERE iduser ='${user.iduser}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM USER WHERE iduser = ?";
  var userResponse = await conn.query(sql, [user.iduser]);

  return Response.ok(userResponse.toString());
}

/* ROLE */
Future<Response> _connectSqlHandlerRole(Request request) async {
  var conn = await _ConnectSql();
  var users = await conn.query('SELECT * FROM role', []);
  return Response.ok(users.toString());
}

Future<Response> _handlerRoleFilter(Request request) async {
  String body = await request.readAsString();
  var obj = json.decode(body);
  var role = "%" + obj['role'] + "%";

  var conn = await _ConnectSql();
  var users = await conn.query('SELECT * FROM role where role like ? ', [role]);

  return Response.ok(users.toString());
}

Future<Response> postRoleData(Request request) async {
  String body = await request.readAsString();
  Role role = roleFromJson(body);

  var conn = await _ConnectSql();
  var sqlExecute = """
      INSERT INTO ROLE (role_id, role)
      VALUES ('${role.role_id}', '${role.role}')
      """;
  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM ROLE WHERE role_id = ?";
  var userResponse = await conn.query(sql, [role.role_id]);

  return Response.ok(userResponse.toString());
}

Future<Response> putRoleData(Request request) async {
  String body = await request.readAsString();
  Role role = roleFromJson(body);

  var conn = await _ConnectSql();
  var sqlExecute = """
      UPDATE ROLE SET
                  role = '${role.role}'
      WHERE role_id = '${role.role_id}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM ROLE WHERE role_id = ?";
  var userResponse = await conn.query(sql, [role.role_id]);

  return Response.ok(userResponse.toString());
}

Future<Response> deleteRole(Request request) async {
  String body = await request.readAsString();
  Role role = roleFromJson(body);

  var conn = await _ConnectSql();
  var sqlExecute = """
      DELETE FROM ROLE WHERE role_id ='${role.role_id}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM ROLE WHERE role_id = ?";
  var userResponse = await conn.query(sql, [role.role_id]);

  return Response.ok(userResponse.toString());
}

/* PROFESI */
Future<Response> _connectSqlHandlerProfesi(Request request) async {
  var conn = await _ConnectSql();
  var users = await conn.query('SELECT * FROM profesi', []);
  return Response.ok(users.toString());
}

Future<Response> _handlerProfesiFilter(Request request) async {
  String body = await request.readAsString();
  var obj = json.decode(body);
  var profesi = "%" + obj['profesi'] + "%";

  var conn = await _ConnectSql();
  var users = await conn
      .query('SELECT * FROM profesi where profesi like ? ', [profesi]);

  return Response.ok(users.toString());
}

Future<Response> postProfesiData(Request request) async {
  String body = await request.readAsString();
  Profesi profesi = profesiFromJson(body);

  var conn = await _ConnectSql();
  var sqlExecute = """
      INSERT INTO PROFESI (profesi_id, profesi)
      VALUES ('${profesi.profesi_id}', '${profesi.profesi}')
      """;
  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM PROFESI WHERE profesi_id = ?";
  var userResponse = await conn.query(sql, [profesi.profesi_id]);

  return Response.ok(userResponse.toString());
}

Future<Response> putProfesiData(Request request) async {
  String body = await request.readAsString();
  Profesi profesi = profesiFromJson(body);

  var conn = await _ConnectSql();
  var sqlExecute = """
      UPDATE PROFESI SET
                  profesi = '${profesi.profesi}'
      WHERE profesi_id = '${profesi.profesi_id}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM PROFESI WHERE profesi_id = ?";
  var userResponse = await conn.query(sql, [profesi.profesi_id]);

  return Response.ok(userResponse.toString());
}

Future<Response> deleteProfesi(Request request) async {
  String body = await request.readAsString();
  Profesi profesi = profesiFromJson(body);

  var conn = await _ConnectSql();
  var sqlExecute = """
      DELETE FROM PROFESI WHERE profesi_id ='${profesi.profesi_id}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM PROFESI WHERE profesi_id = ?";
  var userResponse = await conn.query(sql, [profesi.profesi_id]);

  return Response.ok(userResponse.toString());
}

/* MOTIVASI */
Future<Response> _connectSqlHandlerMotivasi(Request request) async {
  var conn = await _ConnectSql();
  var users = await conn.query('SELECT * FROM motivasi', []);
  return Response.ok(users.toString());
}

Future<Response> _handlerMotivasiFilter(Request request) async {
  String body = await request.readAsString();
  var obj = json.decode(body);
  var isi_motivasi = "%" + obj['isi_motivasi'] + "%";

  var conn = await _ConnectSql();
  var users = await conn.query(
      'SELECT * FROM motivasi where isi_motivasi like ? ', [isi_motivasi]);

  return Response.ok(users.toString());
}

Future<Response> postMotivasiData(Request request) async {
  String body = await request.readAsString();
  Motivasi motivasi = motivasiFromJson(body);
  motivasi.tanggal_input = getDateNow();
  motivasi.tanggal_update = getDateNow();

  var conn = await _ConnectSql();
  var sqlExecute = """
      INSERT INTO motivasi (id, isi_motivasi, iduser, tanggal_input, tanggal_update)
      VALUES ('${motivasi.id}', '${motivasi.isi_motivasi}', '${motivasi.iduser}', '${motivasi.tanggal_input}', '${motivasi.tanggal_update}')
      """;
  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM MOTIVASI WHERE id = ?";
  var userResponse = await conn.query(sql, [motivasi.id]);

  return Response.ok(userResponse.toString());
}

Future<Response> putMotivasiData(Request request) async {
  String body = await request.readAsString();
  Motivasi motivasi = motivasiFromJson(body);
  motivasi.tanggal_update = getDateNow();

  var conn = await _ConnectSql();
  var sqlExecute = """
      UPDATE motivasi SET
                  isi_motivasi = '${motivasi.isi_motivasi}', 
                  iduser = '${motivasi.iduser}', 
                  tanggal_update = '${motivasi.tanggal_update}'
      WHERE id = '${motivasi.id}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM MOTIVASI WHERE id = ?";
  var userResponse = await conn.query(sql, [motivasi.id]);

  return Response.ok(userResponse.toString());
}

Future<Response> deleteMotivasi(Request request) async {
  String body = await request.readAsString();
  Motivasi motivasi = motivasiFromJson(body);

  var conn = await _ConnectSql();
  var sqlExecute = """
      DELETE FROM MOTIVASI WHERE id ='${motivasi.id}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM MOTIVASI WHERE id = ?";
  var userResponse = await conn.query(sql, [motivasi.id]);

  return Response.ok(userResponse.toString());
}

/* SARAN */
Future<Response> _connectSqlHandlerSaran(Request request) async {
  var conn = await _ConnectSql();
  var users = await conn.query('SELECT * FROM saran', []);
  return Response.ok(users.toString());
}

Future<Response> _handlerSaranFilter(Request request) async {
  String body = await request.readAsString();
  var obj = json.decode(body);
  var isi_saran = "%" + obj['isi_saran'] + "%";

  var conn = await _ConnectSql();
  var users = await conn
      .query('SELECT * FROM saran where isi_saran like ? ', [isi_saran]);

  return Response.ok(users.toString());
}

Future<Response> postSaranData(Request request) async {
  String body = await request.readAsString();
  Saran saran = saranFromJson(body);
  saran.tanggal_input = getDateNow();
  saran.tanggal_update = getDateNow();

  var conn = await _ConnectSql();
  var sqlExecute = """
      INSERT INTO SARAN (id, isi_saran, iduser, tanggal_input, tanggal_update)
      VALUES ('${saran.id}', '${saran.isi_saran}', '${saran.iduser}', '${saran.tanggal_input}', '${saran.tanggal_update}')
      """;
  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM SARAN WHERE id = ?";
  var userResponse = await conn.query(sql, [saran.id]);

  return Response.ok(userResponse.toString());
}

Future<Response> putSaranData(Request request) async {
  String body = await request.readAsString();
  Saran saran = saranFromJson(body);
  saran.tanggal_update = getDateNow();

  var conn = await _ConnectSql();
  var sqlExecute = """
      UPDATE saran SET
                  isi_saran = '${saran.isi_saran}', 
                  iduser = '${saran.iduser}', 
                  tanggal_update = '${saran.tanggal_update}'
      WHERE id = '${saran.id}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM SARAN WHERE id = ?";
  var userResponse = await conn.query(sql, [saran.id]);

  return Response.ok(userResponse.toString());
}

Future<Response> deleteSaran(Request request) async {
  String body = await request.readAsString();
  Saran saran = saranFromJson(body);

  var conn = await _ConnectSql();
  var sqlExecute = """
      DELETE FROM SARAN WHERE id ='${saran.id}'
  """;

  var execute = await conn.query(sqlExecute, []);

  var sql = "SELECT * FROM SARAN WHERE id = ?";
  var userResponse = await conn.query(sql, [saran.id]);

  return Response.ok(userResponse.toString());
}

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
