import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../helpers/helpers.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  StreamSubscription categoriesSubscription;
  List<Category> categories = [];
  Store store = GetIt.I<Store>();
  CategoryService categoryService;

  @override
  void initState() {
    super.initState();

    categoryService = CategoryService(store);
    categoriesSubscription = categoryService.listenList((list) {
      setState(() => categories = list ?? []);
    });

    fetch();
  }

  fetch() async {
    try {
      await categoryService.getList();
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    categoriesSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('Categories'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
              context,
              FadeRoute(
                  builder: (context) => EditCategoryPage(0, categoryService)))),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 64.0),
          children: categories
              .map((category) => ListTile(
                    title: Text(category.name),
                    trailing: _DropDownMenu(category, categoryService),
                    onTap: () => Navigator.push(
                      context,
                      FadeRoute(
                          builder: (context) => CategoryPage(category.id)),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _DropDownMenu extends StatelessWidget {
  final Category category;
  final CategoryService categoryService;
  _DropDownMenu(this.category, this.categoryService, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.menu),
      elevation: 16,
      onSelected: (value) {
        if (value == "Edit")
          Navigator.push(
            context,
            FadeRoute(
                builder: (context) =>
                    EditCategoryPage(category.id, categoryService)),
          );
        if (value == "Delete")
          showYesNoDialog(
              context, 'Are you sure?', () => categoryService.delete(category));
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Edit', child: Text('Edit')),
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );
  }
}
