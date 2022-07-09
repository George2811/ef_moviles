import 'package:examen_final/models/category_dish.dart';
import 'package:examen_final/ui/category_detail.dart';
import 'package:examen_final/utils/httphelper.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Category_dish> categories = [];
  HttpHelper? helper;

  Future initialize() async{
    loadMore();
  }
  void loadMore(){
    helper!.getCategories().then((value) {
      categories += value;
      setState(() {
        categories = categories;
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
        title: Text('Best Gourmet'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network("${categories[index].strCategoryThumb}",
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            title: Text('${categories[index].strCategory}'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CategoryDetail(categories[index])));
            },
          );
        },
      ),

    );
  }
}
