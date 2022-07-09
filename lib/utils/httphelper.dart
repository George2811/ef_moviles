import 'package:examen_final/models/category_dish.dart';
import 'package:examen_final/models/dish.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class HttpHelper {
  final String urlCategory = 'https://www.themealdb.com/api/json/v2/9973533/categories.php';
  final String urlDishes = 'https://www.themealdb.com/api/json/v2/9973533/filter.php?c=';

  Future<List<Category_dish>> getCategories() async{
    http.Response result = await http.get(Uri.parse(urlCategory));

    if(result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      final categoriesMap = jsonResponse['categories'];

      List<Category_dish> categories = categoriesMap.map<Category_dish>((i) =>
          Category_dish.fromJson(i)).toList();

      return categories;
    }else{
      print(result.body);
      return null!;
    }
  }

  Future<List<Dish>> getDishes(String name) async{
    final String newUrl = urlDishes + name;
    http.Response result = await http.get(Uri.parse(newUrl));

    if(result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      final dishesMap = jsonResponse['meals'];

      List<Dish> dishes = dishesMap.map<Dish>((i) =>
          Dish.fromJson(i)).toList();
      return dishes;
    }else{
      print(result.body);
      return null!;
    }
  }

}