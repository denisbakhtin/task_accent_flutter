import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../../models/models.dart';
import '../../services/services.dart';

class CategoryDropdownWidget extends StatefulWidget {
  final int value;
  final Function(int value) setCategoryId;
  CategoryDropdownWidget(this.value, this.setCategoryId, {Key key})
      : super(key: key);

  @override
  _CategoryDropdownWidgetState createState() => _CategoryDropdownWidgetState();
}

class _CategoryDropdownWidgetState extends State<CategoryDropdownWidget> {
  CategoryService categoryService = CategoryService(GetIt.I<Store>());
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();

    fetch();
  }

  fetch() async {
    try {
      var _categories = await categoryService.getList();
      setState(() => categories = _categories ?? []);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return (categories.length > 0)
        ? DropdownButton<int>(
            isExpanded: true, //prevents overflow
            value: widget.value,
            hint: Text('Category...'),
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            onChanged: (int newValue) {
              widget.setCategoryId(newValue);
            },
            items: categories
                .map((category) => DropdownMenuItem<int>(
                    value: category.id, child: Text(category.name)))
                .toList(),
          )
        : SizedBox(height: 0);
  }
}
