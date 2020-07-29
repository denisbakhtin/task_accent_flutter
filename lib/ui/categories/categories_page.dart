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
  List<Category> categories = [];
  Store store = GetIt.I<Store>();
  CategoryService categoryService;

  @override
  void initState() {
    super.initState();

    categoryService = CategoryService(store);
    fetch();
  }

  fetch() async {
    try {
      var _categories = await categoryService.getList();
      setState(() => categories = _categories);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  delete(Category category) async {
    try {
      categoryService.delete(category);
      await fetch();
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Widget menu(Category category) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      elevation: 16,
      onSelected: (value) {
        if (value == "Edit")
          Navigator.push(
            context,
            FadeRoute(
                builder: (context) => EditCategoryPage(category.id, fetch)),
          );
        if (value == "Delete")
          showYesNoDialog(context, 'Are you sure?', () => delete(category));
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Edit', child: Text('Edit')),
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AccentScaffold(
      appBar: appBar('Categories'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(context,
              FadeRoute(builder: (context) => EditCategoryPage(0, fetch)))),
      body: SafeArea(
        child: RefreshIndicator(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 64.0),
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: categories?.length ?? 0,
            itemBuilder: (context, index) => Container(
              color: theme.canvasColor,
              child: ListTile(
                title: Text(
                  categories[index].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: menu(categories[index]),
                onTap: () => Navigator.push(
                  context,
                  FadeRoute(
                      builder: (context) => CategoryPage(categories[index].id)),
                ),
              ),
            ),
          ),
          onRefresh: () => fetch(),
        ),
      ),
    );
  }
}
