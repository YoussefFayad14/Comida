import '../local/DatabaseHelper.dart';
import '../models/CategoriesResponse.dart';
import '../models/MealsResponse.dart';
import '../remote/ApiService.dart';

class FoodRepository {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Fetch categories from API
  Future<CategoriesResponse> fetchCategories() async {
    return await _apiService.getCategories();
  }

  // Fetch meals by category from API
  Future<MealsResponse> fetchMealsByCategory(String category) async {
    return await _apiService.getMealsByCategory(category);
  }

  // Fetch meal details by ID from API
  Future<MealsResponse> fetchMealById(String id) async {
    return await _apiService.getMealsById(id);
  }

  // Insert a user into the local database
  Future<int> addUser(String name, String email, String password) async {
    return await _dbHelper.insertUser(name, email, password);
  }

  // Get user from local database
  Future<List<Map<String, dynamic>>> getUser(String email, String password) async {
    return await _dbHelper.getUser(email, password);
  }

  // Insert an order into the local database
  Future<int> addOrder(String itemName, String itemCategory, String imagePath, int quantity) async {
    return await _dbHelper.insertOrder(itemName, itemCategory, imagePath, quantity);
  }

  // Get all orders from the local database
  Future<List<Map<String, dynamic>>> getAllOrders() async {
    return await _dbHelper.getAllOrders();
  }

  // Get orders for a specific user
  Future<List<Map<String, dynamic>>> getOrdersByUser(int userId) async {
    return await _dbHelper.getOrdersByUser(userId);
  }

  // Delete a specific order by its ID
  Future<int> deleteOrder(int orderId) async {
    return await _dbHelper.deleteOrder(orderId);
  }
}
