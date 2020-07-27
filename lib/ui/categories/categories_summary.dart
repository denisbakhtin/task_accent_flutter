import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../shared.dart';

class CategoriesSummaryWidget extends StatefulWidget {
  CategoriesSummaryWidget({Key key}) : super(key: key);

  @override
  CategoriesSummaryWidgetState createState() => CategoriesSummaryWidgetState();
}

class CategoriesSummaryWidgetState extends State<CategoriesSummaryWidget> {
  CategoryService categoryService;
  CategoriesSummary summary = CategoriesSummary(count: 0);

  @override
  void initState() {
    super.initState();

    categoryService = CategoryService(GetIt.I<Store>());
    fetch();
  }

  fetch() async {
    var sum = await categoryService.getSummary();
    setState(() {
      summary = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.push(
        context,
        FadeRoute(builder: (context) => CategoriesPage()),
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(summary.count.toString(), style: theme.textTheme.headline6),
              SizedBox(height: 8),
              Text(
                'Categories',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
