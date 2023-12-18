
import 'package:flutter_dashboard/src/models/api/BaseModel.dart';

class ResponseError{
  final String file;
  final String function;
  final dynamic detail;
  final int line;
  final String code;
  ResponseError({required this.file, required this.function, required this.detail, required this.line, required this.code});

  factory ResponseError.fromJson(Map<String, dynamic> data) {
    return ResponseError(
      file: data["file"],
      function: data["function"],
      line: data["line"],
      code: data["code"],
      detail: data["detail"]
    );
  }

  Map<String, dynamic> toJson() => {
    "file": file,
    "function": function,
    "line": line,
    "code": code,
    "detail": detail,
  };
}

Map<String, dynamic> _empty = {};
class ResponseModel<T extends BaseModel> extends BaseModel{
  late int code;
  late T content;
  late final List<ResponseError> error;

  @override
  ResponseModel.fromJson(Map<String, dynamic> data){
    code = data['code'] as int;
    content = BaseModel.mapToModel<T>(data["content"]);
    Iterable list = data["error"];
    error = list.map((l) => ResponseError.fromJson(l)).toList();
  }

  @override
  ResponseModel.empty(){
    code = 0;
    error = [];
    content = BaseModel.mapToModel<T>({});
  }
  @override
  Map<String, dynamic> toJson() => {
    "code": code,
    "content": content.toJson(),
    "error": error.map((e) => e.toJson()).toList()
  };
}
