

import 'dart:collection';
import 'dart:html' as html;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dashboard/src/constants.dart';
import 'package:flutter_dashboard/src/models/api/ResponseModel.dart';

import '../models/api/BaseModel.dart';


typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);
typedef ApiErrorCallback = void Function(List<ResponseError> errors);
typedef ApiSuccessCallback = void Function(ResponseModel res);

const Map<String, dynamic> _emptyMap = {};
abstract class ApiService {
  Future<ResponseModel<T>> get<T extends BaseModel>({
      required String endpoint,
      Map<String, dynamic> params = _emptyMap,
      ApiErrorCallback? error,
      ApiSuccessCallback? success
    });
  Future<ResponseModel<T>> post<T extends BaseModel>({
    required String endpoint,
    Map<String, dynamic> params = _emptyMap,
    ApiErrorCallback? error,
    ApiSuccessCallback? success
  });
  Future<ResponseModel<T>> upload<T extends BaseModel>({
    required String endpoint,
    required FormData formData,
    ApiErrorCallback? error,
    ApiSuccessCallback? success,
    OnUploadProgressCallback? progress
  });
}

class BaseService implements ApiService{
  late Dio dio;

  static String getHostAddress() {
    if(kIsWeb) {
      final hostname = html.window.location.hostname;
      return "http://"+hostname.toString()+":8080/";
    }
    return "http://localhost:8080/";
  }
  String apiUrl;
  BuildContext? context;

  BaseService({required this.apiUrl, this.context}){
    dio = Dio();
  }

  static void errorHandle(BuildContext context, List<ResponseError> errors){
    for (var element in errors) {
      print(element.toJson());
      showSnackBar(context, element.detail.toString());
    }
  }

  @override
  Future<ResponseModel<T>> get<T extends BaseModel>({
    required String endpoint,
    Map<String, dynamic> params = _emptyMap,
    ApiErrorCallback? error,
    ApiSuccessCallback? success,
  }) async{
    Response<String> response = await dio.get(
      apiUrl + endpoint,
      queryParameters: params,
      options: Options(
        validateStatus: (status) {
          return true;
        },
      )
    );
    Map<String, dynamic> js = json.decode(response.data!);
    ResponseModel<T> responseModel = ResponseModel<T>.fromJson(js);
    if(error != null) error(responseModel.error);

    if(response.statusCode == 200){
      if(success != null){
        success(responseModel);
      }
      return responseModel;
    }

    return ResponseModel<T>.empty();
  }

  @override
  Future<ResponseModel<T>> post<T extends BaseModel>({
    required String endpoint,
    Map<String, dynamic> params = _emptyMap,
    ApiErrorCallback? error,
    ApiSuccessCallback? success,
  }) async{
    Response<String> response = await dio.post(
        apiUrl + endpoint,
        data: params,
        options: Options(
          validateStatus: (status) {
            return true;
          },
        )
    );
    Map<String, dynamic> js = json.decode(response.data!);
    ResponseModel<T> responseModel = ResponseModel<T>.fromJson(js);
    if(error != null) error(responseModel.error);

    if(response.statusCode == 200){
      if(success != null){
        success(responseModel);
      }
      return responseModel;
    }
    return ResponseModel.empty();
  }

  @override
  Future<ResponseModel<T>> upload<T extends BaseModel>({
    required String endpoint,
    required FormData formData,
    ApiErrorCallback? error,
    ApiSuccessCallback? success,
    OnUploadProgressCallback? progress
  }) async {
    Response<String> response = await dio.post(apiUrl + endpoint,
      data: formData,
      onSendProgress: (count, total) {
        if(progress!= null){
          progress(count, total);
        }
      },
        options: Options(
          validateStatus: (status) {
            return true;
          },
        )
    );
    Map<String, dynamic> js = json.decode(response.data!);
    ResponseModel<T> responseModel = ResponseModel<T>.fromJson(js);
    if(error != null) error(responseModel.error);

    if(response.statusCode == 200){
      if(success != null){
        success(responseModel);
      }
      return responseModel;
    }
    return ResponseModel.empty();
  }


}
