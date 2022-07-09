import 'package:examen_final/models/category_dish.dart';
import 'package:examen_final/models/dish.dart';
import 'package:examen_final/ui/category_view.dart';
import 'package:examen_final/utils/httphelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatefulWidget {
  final Category_dish category;
  CategoryDetail(this.category);
  /*const CategoryDetail({Key? key, }) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();*/
  @override
  _CategoryDetailState createState() => _CategoryDetailState(category);
}

class _CategoryDetailState extends State<CategoryDetail> {
  final Category_dish category;
  List<Dish> dishes = [];
  HttpHelper? helper;

  _CategoryDetailState(this.category);

  Future initialize() async{
    loadMore();
  }
  void loadMore(){
    helper!.getDishes('${category.strCategory}').then((value) {
      dishes += value;
      setState(() {
        dishes = dishes;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${category.strCategory} Detail'),
      ),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.network("${category.strCategoryThumb}",
                    width: 200,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                ),
                Text('${category.strCategoryDescription}', textAlign: TextAlign.justify,),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  height: 2,
                  width: 161,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: dishes.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network("${dishes[index].strMealThumb}",
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text('${dishes[index].strMeal}'),
                    onTap: () {

                    },
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
