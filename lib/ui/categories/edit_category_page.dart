import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';

class EditCategoryPage extends StatefulWidget {
  final int id;
  final Function onUpdate;
  EditCategoryPage(this.id, this.onUpdate);
  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  Store store = GetIt.I<Store>();
  CategoryService categoryService;
  Category category;
  String error;
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    categoryService = CategoryService(store);
    if (widget.id > 0)
      fetch();
    else
      category = Category();
  }

  fetch() async {
    try {
      var _category = await categoryService.get(widget.id);
      setState(() {
        error = null;
        category = _category;
        _nameController.text = category.name;
      });
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  onSave() async {
    category.name = _nameController.text;
    try {
      if (widget.id > 0)
        await categoryService.update(category);
      else
        await categoryService.create(category);

      if (widget.onUpdate != null) widget.onUpdate();
      Navigator.pop(context);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AccentScaffold(
      appBar: appBar('Edit Category'),
      drawer: drawer(context),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            MaterialInput(
              controller: _nameController,
              autofocus: true,
              label: 'Name',
            ),
            SizedBox(height: 8.0),
            Error(error),
            Row(
              children: <Widget>[
                PrimaryButton(text: 'Save', onPressed: onSave),
                DefaultButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
