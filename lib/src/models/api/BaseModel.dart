import 'package:flutter_dashboard/src/models/api/ListResponse.dart';
import 'package:flutter_dashboard/src/models/api/User.dart';

abstract class BaseModel{

  static T mapToModel<T extends BaseModel>(Map<String, dynamic>? json) {
    switch (T) {
      case User:
        return json == null ? User.fromJson({}) as T: User.fromJson(json) as T;
      case const (ListResponse<User>):
        return json == null ? ListResponse as T : ListResponse<User>.fromJson(json) as T;
      default:
        throw UnimplementedError();
    }
  }
  BaseModel();
  Map<String, dynamic> toJson();
  BaseModel.fromJson(Map<String, dynamic> data);
}