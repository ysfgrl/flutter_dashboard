
import 'package:flutter_dashboard/src/models/api/BaseModel.dart';

class ListResponse<T extends BaseModel> extends BaseModel {
  late int page;
  late int pageSize;
  late int total;
  late List<T> list;

  @override
  ListResponse.fromJson(Map<String, dynamic> data){
    page = data["page"] ?? 1;
    pageSize = data["pageSize"] ?? 10;
    total = data["total"] ?? 0;
    Iterable iterable = data["list"] ?? [];
    list = iterable.map((e) => BaseModel.mapToModel<T>(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() => {
    "page": page,
    "pageSize": pageSize,
    "total": total,
    "list": list.map((e) => e.toJson()).toList(),
  };
}
