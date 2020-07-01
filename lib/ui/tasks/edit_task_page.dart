import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../shared.dart';
import 'priority_dropdown.dart';

class EditTaskPage extends StatefulWidget {
  final int id;
  final Function onUpdate;
  EditTaskPage(this.id, this.onUpdate);
  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TaskService taskService;
  StreamSubscription taskSubscription;
  StreamSubscription tasksSubscription;
  Task task;
  String error;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    taskService = TaskService(GetIt.I<Store>());
    taskSubscription = taskService.listen((t) {
      setState(() {
        error = null;
        if (t != null) {
          task = t;
          _nameController.text = task.name;
          _descriptionController.text = task.description;
          task.attachedFiles ??= [];
        }
      });
    });
    //service's create and update methods, write into List streams
    tasksSubscription = taskService.listenList((list) {
      widget.onUpdate(); //fire callback to refresh list
      Navigator.pop(context);
    });

    if (widget.id > 0)
      fetch();
    else
      task = Task(priority: PRIORITY4);
  }

  fetch() async {
    try {
      await taskService.get(id: widget.id);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    taskSubscription.cancel();
    tasksSubscription.cancel();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  onFilesChange(List<AttachedFile> files) =>
      setState(() => task?.attachedFiles = files);

  void onSave() async {
    task.name = _nameController.text;
    task.description = _descriptionController.text;
    try {
      if (widget.id > 0)
        await taskService.update(task);
      else
        await taskService.create(task);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(widget.id > 0 ? 'Edit Task' : 'New Task'),
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
              Material(
                child: TextField(
                  controller: _descriptionController,
                  minLines: 3,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              ProjectDropdownWidget(task?.projectId,
                  (int value) => setState(() => task.projectId = value)),
              CategoryDropdownWidget(task?.categoryId,
                  (int value) => setState(() => task.categoryId = value)),
              PriorityDropdownWidget(task?.priority,
                  (int value) => setState(() => task.priority = value)),
              DatePicker(
                  task?.startDate,
                  (value) => setState(() => task.startDate = value),
                  "Start Date"),
              DatePicker(task?.endDate,
                  (value) => setState(() => task.endDate = value), "End Date"),
              SizedBox(height: 8.0),
              AttachedFilesWidget(task?.attachedFiles, onFilesChange),
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
