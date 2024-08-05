import 'package:dio/dio.dart';
import '../models/products_cat.dart';
import '../models/products_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_models.dart';

class ApiProvider {
  UserModel? userModel;
  ProductsOfCategoryModel? productsOfCategoryModel;
  String? token;
  ProductsModel? productModel;
  static const String baseURL = "https://dummyjson.com";

  Future<ProductsModel?> getProducts() async {
    try {
      Response response = await Dio().get(
        "$baseURL/products",
        queryParameters: {
          "select": "title,price,images,category,description,brand",
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      productModel = ProductsModel.fromJson(response.data);
      print(productModel?.products![0].title);
      return productModel;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserModel?> getUser() async {
    try {
      Response response = await Dio().get(
        "$baseURL/users/1",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      userModel = UserModel.fromJson(response.data);
      return userModel;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ProductsOfCategoryModel?> getProductsByCategory(
      String category) async {
    try {
      Response response = await Dio().get(
        "$baseURL/products/category/$category",
        queryParameters: {
          "select": "id,title,category,thumbnail,price",
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      productsOfCategoryModel = ProductsOfCategoryModel.fromJson(response.data);
      return productsOfCategoryModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<String>> getCategories() async {
    try {
      Response response = await Dio().get("$baseURL/products/category-list");
      List<String> categories = List<String>.from(response.data);
      return categories;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> registerUser({
    required String username,
    required String password,
    required String email,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      FormData userData = FormData.fromMap({
        "email": email,
        "username": username,
        "password": password,
      });
      Response response = await Dio().post(
        "$baseURL/auth/register",
        data: userData,
      );
      await prefs.setString("userToken", response.data["token"]);

      token = prefs.getString('userToken');
      return "Registration Success";
    } catch (e) {
      if (e is DioException) {
        return e.response?.data["message"];
      }
      return "Registration Failed";
    }
  }

  Future<String> userLogin({
    required String username,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      FormData userData = FormData.fromMap({
        "username": username,
        "password": password,
      });
      Response response = await Dio().post(
        "$baseURL/auth/login",
        data: userData,
      );
      await prefs.setString("userToken", response.data["token"]);

      token = prefs.getString('userToken');
      return "Login Success";
    } catch (e) {
      if (e is DioException) {
        return e.response?.data["message"];
      }
      return "Login Failed";
    }
  }
}
