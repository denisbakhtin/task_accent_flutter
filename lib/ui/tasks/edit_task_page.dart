import 'dart:io';

import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../shared.dart';
import 'priority_dropdown.dart';

class EditTaskPage extends StatefulWidget {
  final int id;
  final Function onUpdate;
  final int projectId;
  EditTaskPage(this.id, this.onUpdate, {this.projectId});
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
      task = Task(
          priority: PRIORITY4, projectId: widget.projectId, attachedFiles: []);
  }

  fetch() async {
    try {
      error = null;
      await taskService.get(id: widget.id);
    } on SocketException catch (_) {
      setState(() => error = "No internet connection");
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
    } on SocketException catch (_) {
      setState(() => error = "No internet connection");
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AccentScaffold(
      appBar: appBar(widget.id > 0 ? 'Edit Task' : 'New Task'),
      drawer: drawer(context),
      error: error,
      refresh: fetch,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            MaterialInput(
              autofocus: true,
              label: 'Name',
              controller: _nameController,
            ),
            SizedBox(height: 8.0),
            MaterialInput(
              minLines: 3,
              maxLines: 10,
              label: 'Description',
              controller: _descriptionController,
            ),
            SizedBox(height: 8.0),
            ProjectDropdownWidget(task?.projectId,
                (int value) => setState(() => task.projectId = value)),
            SizedBox(height: 8.0),
            CategoryDropdownWidget(task?.categoryId,
                (int value) => setState(() => task.categoryId = value)),
            SizedBox(height: 8.0),
            PriorityDropdownWidget(task?.priority,
                (int value) => setState(() => task.priority = value)),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: DatePicker(
                      task?.startDate,
                      (value) => setState(() => task.startDate = value),
                      "Start Date"),
                ),
                Expanded(
                  child: DatePicker(
                      task?.endDate,
                      (value) => setState(() => task.endDate = value),
                      "End Date"),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            AttachedFilesWidget(task?.attachedFiles, onFilesChange),
            Row(
              children: <Widget>[
                PrimaryButton(text: 'Save', onPressed: onSave),
                SizedBox(width: 8),
                DefaultButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
