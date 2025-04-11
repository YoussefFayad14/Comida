import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../models/CategoriesResponse.dart';
import '../models/MealsResponse.dart';

class ApiService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.themealdb.com/api/json/v1/1',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  )..interceptors.add(PrettyDioLogger());

  Future<CategoriesResponse> getCategories() async {
    try {
      final response = await _dio.get('$baseUrl/categories.php');
      if (response.statusCode == 200) {
        print("data $response");
        return CategoriesResponse.fromJson(response.data);
      }else{
        print("No Data");
        return CategoriesResponse.fromJson(response.data);
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<MealsResponse> getMealsByCategory(String category) async {
    try {
      final response = await _dio.get('$baseUrl/filter.php', queryParameters: {'c': category});
      if (response.statusCode == 200) {
        print("data $response");
        return MealsResponse.fromJson(response.data);
      }else{
        print("No Data");
        return MealsResponse.fromJson(response.data);
      }
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }

  Future<MealsResponse> getMealsById(String id) async {
    try {
      final response = await _dio.get('$baseUrl/lookup.php', queryParameters: {'i': id});
      if (response.statusCode == 200) {
        print("data $response");
        return MealsResponse.fromJson(response.data);
      }else{
        print("No Data");
        return MealsResponse.fromJson(response.data);
      }
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }

}
