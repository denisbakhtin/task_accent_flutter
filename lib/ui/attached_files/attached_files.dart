import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import '../shared.dart';
import 'package:url_launcher/url_launcher.dart';
import 'attached_file_page.dart';

class AttachedFilesWidget extends StatefulWidget {
  final List<AttachedFile> files;
  final Function(List<AttachedFile> files) onFilesChange;
  AttachedFilesWidget(this.files, this.onFilesChange);
  @override
  _AttachedFilesWidgetState createState() => _AttachedFilesWidgetState();
}

class _AttachedFilesWidgetState extends State<AttachedFilesWidget> {
  AttachedFileService fileService = AttachedFileService(GetIt.I<Store>());
  String error;
  String _path;

  void _openFileExplorer() async {
    try {
      _path = await FilePicker.getFilePath(type: FileType.ANY);
      var file = await fileService.upload(_path);
      widget.files.add(file);
      widget.onFilesChange(widget.files);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  String _fileType(String path) {
    var mtype = lookupMimeType(path);
    return mtype.split("/").first;
  }

  void _viewFile(String path) async {
    var ftype = _fileType(path);
    if (ftype == "image" || ftype == "video")
      await Navigator.push(
        context,
        FadeRoute(builder: (context) => AttachedFilePage(path)),
      );
    else
      await _launchURL(path);
  }

  _launchURL(String path) async {
    if (await canLaunch(path)) {
      await launch(path);
    } else {
      setState(() => error = "Can't open url $path");
    }
  }

  List<Widget> buildItems(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var items = List<Widget>();
    var readOnly = widget.onFilesChange == null;
    if (readOnly) {
      if (widget.files.length > 0)
        items.add(Padding(
            padding: EdgeInsets.only(right: 4),
            child: Icon(
              Icons.attach_file,
              color: theme.primaryColorDark,
              size: 13,
            )));
      items.addAll(widget.files
          .map(
            (file) => Padding(
              padding: EdgeInsets.only(right: 8),
              child: InkWell(
                  child: Text(file.name,
                      style: theme.textTheme.caption
                          .copyWith(color: theme.primaryColor)),
                  onTap: () => _viewFile(baseURL + file.url)),
            ),
          )
          .toList());
    } else {
      items.addAll(widget.files
          .map(
            (file) => Padding(
              padding: EdgeInsets.only(right: 8),
              child: Dismissible(
                key: Key(file.id.toString()),
                onDismissed: (direction) => setState(() {
                  widget.files.remove(file);
                  widget.onFilesChange(widget.files);
                }),
                background: Container(color: Color(0x77FF0000)),
                child: MaterialButton(
                    child: Text(file.name),
                    color: theme.buttonColor,
                    onPressed: () => _viewFile(baseURL + file.url)),
              ),
            ),
          )
          .toList());
      items.add(
        Padding(
            padding: EdgeInsets.only(right: 8),
            child: MaterialButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.attach_file), Text('Add')],
                ),
                color: theme.buttonColor,
                onPressed: _openFileExplorer)),
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return widget.files != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: buildItems(context),
              ),
              Error(error),
            ],
          )
        : SizedBox(height: 0);
  }
}
