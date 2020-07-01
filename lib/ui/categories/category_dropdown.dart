import 'package:flutter/material.dart';
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
  StreamSubscription categoriesSubscription;
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();

    categoriesSubscription = categoryService.listenList((list) {
      setState(() => categories = list ?? []);
    }, onError: (Object err) {});
    categoryService.getList();
  }

  @override
  void dispose() {
    super.dispose();
    categoriesSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return (categories.length > 0)
        ? DropdownButton<int>(
            isExpanded: true, //prevents overflow
            value: widget.value,
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
