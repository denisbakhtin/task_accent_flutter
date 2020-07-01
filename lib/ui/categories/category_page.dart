import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';

class CategoryPage extends StatefulWidget {
  final int id;
  CategoryPage(this.id);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  StreamSubscription categorySubscription;
  Category category;
  Store store = GetIt.I<Store>();
  CategoryService categoryService;
  String error;

  @override
  void initState() {
    super.initState();

    categoryService = CategoryService(store);
    categorySubscription = categoryService.listen((proj) {
      setState(() {
        error = null;
        category = proj;
      });
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });
    categoryService.get(id: widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    categorySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('Category'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Text(category?.name ?? "Loading"),
        ),
      ),
    );
  }
}
