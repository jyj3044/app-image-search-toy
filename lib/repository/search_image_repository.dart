import 'package:app_image_search_toy/constant/define.dart';
import 'package:app_image_search_toy/core/log.dart';
import 'package:app_image_search_toy/data/model/Image_model.dart';
import 'package:dio/dio.dart';

abstract class SearchImageRepository {
  static final _baseOptions = BaseOptions(
    baseUrl: KakaoUrl.baseUrl,
    contentType: Headers.jsonContentType,
    validateStatus: (int? status) {
      return status != null;
    },
    headers: {
      'Authorization': KakaoKey.restApiKey,
    },
  );

  static final _dio = Dio(_baseOptions);

  static Future<ImageModel> searchImage(String searchText, {int size = 10, int page = 1}) async {
    Log.i("searchImage $searchText size: $size page: $page");
    final response = await _dio.get(KakaoUrl.searchImage, queryParameters: {'query': searchText, 'size': size, 'page': page});
    Log.i("searchImage $response");
    return ImageModel.fromJson(response.data);
  }
}
