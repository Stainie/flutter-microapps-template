import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_abstraction/dio/request_options_impl.dart';

import 'package:http_abstraction/http_abstraction.dart';
import 'package:http_parser/http_parser.dart';

extension HttpRequestDioExtension on HttpRequest {
  RequestOptionsImpl toRequestOptions() {
    final typeMap = <String, String>{
      'jpg': 'image',
      'jpeg': 'image',
      'png': 'image',
      'gif': 'image',
      'pdf': 'application',
      'doc': 'application',
      'docx': 'application',
      'xls': 'application',
      'xlsx': 'application',
      'ppt': 'application',
      'pptx': 'application',
      'txt': 'text',
      'csv': 'text',
      'zip': 'application',
      'rar': 'application',
    };

    final extensionMap = <String, String>{
      'jpg': 'jpeg',
      'jpeg': 'jpeg',
      'png': 'png',
      'gif': 'gif',
      'pdf': 'pdf',
      'doc': 'msword',
      'docx': 'vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls': 'vnd.ms-excel',
      'xlsx': 'vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'ppt': 'vnd.ms-powerpoint',
      'pptx': 'vnd.openxmlformats-officedocument.presentationml.presentation',
      'txt': 'plain',
      'csv': 'csv',
      'zip': 'zip',
      'rar': 'rar',
    };

    if (body is HttpBodyForm) {
      final body = this.body as HttpBodyForm;

      final filesFromPath = body.files?.map(
        (key, value) {
          final fileName = value.path.split('/').last;
          final extension = fileName.split('.').last;
          debugPrint(fileName);
          return MapEntry(
            key,
            MultipartFile.fromFileSync(
              value.path,
              filename: fileName,
              contentType:
                  MediaType(typeMap[extension]!, extensionMap[extension]!),
            ),
          );
        },
      );

      final data = FormData.fromMap({
        ...body.data,
        if (filesFromPath != null) ...filesFromPath,
      });

      return RequestOptionsImpl(
        method: method.name.toUpperCase(),
        path: endpoint,
        queryParameters: queryParameters,
        data: data,
        headers: headers,
        baseUrl: baseUrl,
        body: body,
      );
    }

    final data = body as HttpBodyJson;
    final request = RequestOptionsImpl(
      method: method.name.toUpperCase(),
      path: endpoint,
      queryParameters: queryParameters,
      data: data.data,
      headers: headers,
      baseUrl: baseUrl,
      body: body,
    );

    return request;
  }
}

extension DioRequestExtension on RequestOptionsImpl {
  HttpRequest toHttpRequest() => HttpRequest(
        method: HttpMethodEnum.values
            .firstWhere((e) => e.name == method.toLowerCase()),
        endpoint: path,
        queryParameters: queryParameters,
        body: body,
        headers: headers,
        baseUrl: baseUrl,
      );
}
