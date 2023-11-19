// To parse this JSON data, do
//
//     final studentInfoResponse = studentInfoResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'student_info_response.g.dart';

StudentInfoResponse studentInfoResponseFromJson(String str) => StudentInfoResponse.fromJson(json.decode(str));

String studentInfoResponseToJson(StudentInfoResponse data) => json.encode(data.toJson());

@JsonSerializable()
class StudentInfoResponse {
  @JsonKey(name: "data")
  Data data;

  StudentInfoResponse({
    required this.data,
  });

  factory StudentInfoResponse.fromJson(Map<String, dynamic> json) => _$StudentInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StudentInfoResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "records")
  List<StudentInfo> records;

  Data({
    required this.records,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class StudentInfo {
  @JsonKey(name: "currentUserId")
  String currentUserId;
  @JsonKey(name: "userRoleId")
  String userRoleId;
  @JsonKey(name: "dataAuth")
  bool dataAuth;
  @JsonKey(name: "dataXnxq")
  String dataXnxq;
  @JsonKey(name: "currentRoleId")
  String currentRoleId;
  @JsonKey(name: "currentJsId")
  String currentJsId;
  @JsonKey(name: "currentUserName")
  String currentUserName;
  @JsonKey(name: "currentDepartmentId")
  String currentDepartmentId;
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "xh")
  String xh;
  @JsonKey(name: "xm")
  String xm;
  @JsonKey(name: "xmpy")
  String xmpy;
  @JsonKey(name: "xbdm")
  String xbdm;
  @JsonKey(name: "zzmmdm")
  String zzmmdm;
  @JsonKey(name: "zjlxdm")
  String zjlxdm;
  @JsonKey(name: "sfzjh")
  String sfzjh;
  @JsonKey(name: "csrq")
  DateTime csrq;
  @JsonKey(name: "mzdm")
  String mzdm;
  @JsonKey(name: "jtzz")
  String jtzz;
  @JsonKey(name: "ksh")
  String ksh;
  @JsonKey(name: "createBy")
  AteBy createBy;
  @JsonKey(name: "createDate")
  DateTime createDate;
  @JsonKey(name: "updateBy")
  AteBy updateBy;
  @JsonKey(name: "updateDate")
  DateTime updateDate;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "gkzp")
  String gkzp;
  @JsonKey(name: "yxdm")
  String yxdm;
  @JsonKey(name: "zydm")
  String zydm;
  @JsonKey(name: "sznj")
  String sznj;
  @JsonKey(name: "rxnj")
  String rxnj;
  @JsonKey(name: "bjdm")
  String bjdm;
  @JsonKey(name: "xslbdm")
  String xslbdm;
  @JsonKey(name: "pyccdm")
  String pyccdm;
  @JsonKey(name: "xjzt")
  String xjzt;
  @JsonKey(name: "xsdqztdm")
  String xsdqztdm;
  @JsonKey(name: "rxnf")
  DateTime rxnf;
  @JsonKey(name: "xz")
  String xz;
  @JsonKey(name: "sfzx")
  String sfzx;
  @JsonKey(name: "zymc")
  String zymc;
  @JsonKey(name: "bjmc")
  String bjmc;
  @JsonKey(name: "yxmc")
  String yxmc;
  @JsonKey(name: "xxzydm")
  String xxzydm;
  @JsonKey(name: "wfwtbzt")
  String wfwtbzt;
  @JsonKey(name: "new")
  bool recordNew;

  StudentInfo({
    required this.currentUserId,
    required this.userRoleId,
    required this.dataAuth,
    required this.dataXnxq,
    required this.currentRoleId,
    required this.currentJsId,
    required this.currentUserName,
    required this.currentDepartmentId,
    required this.id,
    required this.xh,
    required this.xm,
    required this.xmpy,
    required this.xbdm,
    required this.zzmmdm,
    required this.zjlxdm,
    required this.sfzjh,
    required this.csrq,
    required this.mzdm,
    required this.jtzz,
    required this.ksh,
    required this.createBy,
    required this.createDate,
    required this.updateBy,
    required this.updateDate,
    required this.status,
    required this.gkzp,
    required this.yxdm,
    required this.zydm,
    required this.sznj,
    required this.rxnj,
    required this.bjdm,
    required this.xslbdm,
    required this.pyccdm,
    required this.xjzt,
    required this.xsdqztdm,
    required this.rxnf,
    required this.xz,
    required this.sfzx,
    required this.zymc,
    required this.bjmc,
    required this.yxmc,
    required this.xxzydm,
    required this.wfwtbzt,
    required this.recordNew,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) => _$StudentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$StudentInfoToJson(this);
}

@JsonSerializable()
class AteBy {
  @JsonKey(name: "currentUserId")
  String currentUserId;
  @JsonKey(name: "userRoleId")
  String userRoleId;
  @JsonKey(name: "dataAuth")
  bool dataAuth;
  @JsonKey(name: "dataXnxq")
  String dataXnxq;
  @JsonKey(name: "currentRoleId")
  String currentRoleId;
  @JsonKey(name: "currentJsId")
  String currentJsId;
  @JsonKey(name: "currentUserName")
  String currentUserName;
  @JsonKey(name: "currentDepartmentId")
  String currentDepartmentId;
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "credentialsSalt")
  String credentialsSalt;
  @JsonKey(name: "new")
  bool ateByNew;

  AteBy({
    required this.currentUserId,
    required this.userRoleId,
    required this.dataAuth,
    required this.dataXnxq,
    required this.currentRoleId,
    required this.currentJsId,
    required this.currentUserName,
    required this.currentDepartmentId,
    required this.id,
    required this.status,
    required this.credentialsSalt,
    required this.ateByNew,
  });

  factory AteBy.fromJson(Map<String, dynamic> json) => _$AteByFromJson(json);

  Map<String, dynamic> toJson() => _$AteByToJson(this);
}
