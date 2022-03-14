//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'crud_sharedpref.dart';

class AddListPage extends StatefulWidget {
  final title;
  final description;
  final isVisible;

  AddListPage({
    Key? key,
    required this.title,
    required this.description,
    required this.isVisible,
  }) : super(key: key);

  @override
  _AddListPageState createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  List<String> titleList = <String>[];
  List<String> descriptionList = <String>[];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool visibility = true;

  String editTitle = "";
  String editDescription = "";

  @override
  void initState() {
    super.initState();
    editTitle = titleController.text = widget.title;
    editDescription = descriptionController.text = widget.description;
    visibility = widget.isVisible;
  }

  _addTask() async {
    await Crud().createData("todo_title", titleController.text);
    await Crud().createData("todo_description", descriptionController.text);
    _showSnackBar("Task added!");
    Navigator.pop(context);
  }

  _editTask() async {
    await Crud().editData("todo_title", editTitle, titleController.text);
    await Crud().editData(
        "todo_description", editDescription, descriptionController.text);
    _showSnackBar("Task Edited Successfully!");
    Navigator.pop(context);
  }

  _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List App"),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/images/background.jpg"),
              fit: BoxFit.fill),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            titleTextField(),
            SizedBox(height: 10),
            descriptionTextField(),
            SizedBox(height: 10),
            buttons(),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextField(
        controller: titleController,
        autofocus: false,
        style: TextStyle(fontSize: 22.0, color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          hintText: 'Enter Title',
          labelText: "Task Title",
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget descriptionTextField() {
    return Flexible(
      child: Container(
        //height: 100,
        child: TextFormField(
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          style: TextStyle(fontSize: 22.0, color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              //color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Enter Task Description',
          ),
        ),
      ),
    );
  }

  Widget buttons() {
    return Center(
      child: Column(
        children: <Widget>[
          Visibility(
            visible: visibility,
            child: SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _addTask();
                },
                child: Text('Set Task'),
              ),
            ),
          ),
          Visibility(
            visible: !visibility,
            child: SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _editTask();
                },
                child: Text('Edit Task'),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 100,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ),
        ],
      ),
    );
  }
}
