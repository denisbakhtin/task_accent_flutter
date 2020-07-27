import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../projects/project_preview.dart';
import '../tasks/task_preview.dart';

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
  ProjectService projectService;
  TaskService taskService;

  @override
  void initState() {
    super.initState();

    categoryService = CategoryService(store);
    projectService = ProjectService(store);
    taskService = TaskService(store);
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
    return AccentScaffold(
      appBar: appBar('Category'),
      drawer: drawer(context),
      body: SafeArea(
        child: category != null
            ? RefreshIndicator(
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    Text(category.name, style: theme.textTheme.headline6),
                    (category.projects?.length ?? 0) > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                SizedBox(height: 8),
                                Text('Projects'),
                                SizedBox(height: 8),
                                ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      ListDivider(),
                                  itemCount: category.projects?.length ?? 0,
                                  itemBuilder: (context, index) =>
                                      ProjectPreviewWidget(
                                          category.projects[index], fetch),
                                ),
                              ])
                        : SizedBox(height: 0),
                    (category.tasks?.length ?? 0) > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                SizedBox(height: 12),
                                Text('Tasks'),
                                SizedBox(height: 8),
                                ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      ListDivider(),
                                  itemCount: category.tasks?.length ?? 0,
                                  itemBuilder: (context, index) =>
                                      TaskPreviewWidget(
                                          category.tasks[index], fetch),
                                ),
                              ])
                        : SizedBox(height: 0),
                  ],
                ),
                onRefresh: () => fetch(),
              )
            : Loading(),
      ),
    );
  }
}
