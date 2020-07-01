import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
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

  @override
  void initState() {
    super.initState();

    categoryService = CategoryService(store);
    categorySubscription = categoryService.listen((cat) {
      setState(() => category = cat);
    });
    fetch();
  }

  fetch() async {
    try {
      await categoryService.get(id: widget.id);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
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
