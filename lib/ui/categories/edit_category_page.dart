import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';

class EditCategoryPage extends StatefulWidget {
  final int id;
  final CategoryService categoryService;
  EditCategoryPage(this.id, this.categoryService);
  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  StreamSubscription categorySubscription;
  StreamSubscription categoriesSubscription;
  Category category;
  String error;
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    categorySubscription = widget.categoryService.listen((cat) {
      setState(() {
        error = null;
        if (cat != null) {
          category = cat;
          _nameController.text = category.name;
        }
      });
    });
    categoriesSubscription = widget.categoryService.listenList((list) {
      Navigator.pop(context);
    });

    if (widget.id > 0)
      fetch();
    else
      category = Category();
  }

  fetch() async {
    try {
      await widget.categoryService.get(id: widget.id);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  onSave() async {
    category.name = _nameController.text;
    try {
      if (widget.id > 0)
        await widget.categoryService.update(category);
      else
        await widget.categoryService.create(category);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    categorySubscription.cancel();
    categoriesSubscription.cancel();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('Edit Category'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                child: TextField(
                  controller: _nameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Error(error),
              Row(
                children: <Widget>[
                  MaterialButton(child: Text('Save'), onPressed: onSave),
                  MaterialButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
