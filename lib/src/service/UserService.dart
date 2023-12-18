

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dashboard/src/models/api/ListRequest.dart';
import 'package:flutter_dashboard/src/models/api/ListResponse.dart';
import 'package:flutter_dashboard/src/models/api/ResponseModel.dart';
import 'package:flutter_dashboard/src/models/api/User.dart';
import 'package:flutter_dashboard/src/service/ApiService.dart';
import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';

class UserService extends BaseService {

  UserService({required super.apiUrl, super.context});

  Future<User> getById(String id, {ApiErrorCallback? errorCallback}) async{

    ResponseModel<User> responseModel = await super.get<User>(
        endpoint: "User/get/"+id,
        error: errorCallback
    );
    if(responseModel.code == 200) {
      return responseModel.content;
    }
    return User.fromJson({});
  }

  Future<User> add(User data, {ApiErrorCallback? errorCallback}) async{

    ResponseModel<User> responseModel = await super.post<User>(
        endpoint: "User/add",
        params: data.toJson(),
        error: errorCallback
    );
    if(responseModel.code == 200) {
      return responseModel.content;
    }
    return  User.fromJson({});
  }

  Future<ListResponse<User>> getList(ListRequest listRequest, {ApiErrorCallback? errorCallback}) async{
    ResponseModel<ListResponse<User>> responseModel = await super.get<ListResponse<User>>(
        endpoint: "User/list",
        params: listRequest.toJson(),
        error: errorCallback
    );
    if(responseModel.code == 200){
      return responseModel.content;
    }
    return ListResponse<User>.fromJson({});
  }

  Future<User> uploadFile(PlatformFile file, {ApiErrorCallback? errorCallback, OnUploadProgressCallback? progress} ) async {
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
          file.bytes!,
          filename: file.name,
        contentType: MediaType.parse(lookupMimeType(file.name!).toString())
      )
    });
    ResponseModel<User> responseModel = await super.upload<User>(
        endpoint: "User/upload",
        formData: formData,
        error: errorCallback,
        progress: progress
    );
    if(responseModel.code == 200){
      return responseModel.content;
    }
    return  User.fromJson({});
  }

}
