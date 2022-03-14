import 'package:flutter/material.dart';
import 'package:todo_list_app/crud_sharedpref.dart';
import 'package:todo_list_app/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> titleList = <String>[];
  List<String> descriptionList = <String>[];
  int dataLen = 0;

  bool value = false;

  getTask() async {
    await Crud().getDataList("todo_title").then((value) {
      titleList = value;
    });

    await Crud().getDataList("todo_description").then((value) {
      descriptionList = value;
    });

    await Crud().getDataLength("todo_title").then((value) {
      dataLen = value;
    });
    setState(() {});
  }

  void deleteData(String delItem1, String delItem2) async {
    await Crud().deleteData(delItem1, "todo_title");
    await Crud().deleteData(delItem2, "todo_description");
    setState(() {});
    getTask();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task deleted!'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getTask();
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
        child: toDoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddListPage(
                title: "",
                description: "",
                isVisible: true,
              ),
            ),
          );
          getTask();
        },
        tooltip: 'Add To Do List',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget toDoList() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: dataLen,
              itemBuilder: (context, index) => Card(
                elevation: 6,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  tileColor: Colors.green[100],
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddListPage(
                          title: titleList[index],
                          description: descriptionList[index],
                          isVisible: false,
                        ),
                      ),
                    );
                    getTask();
                  },
                  leading: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteData(titleList[index], descriptionList[index]);

                      getTask();
                    },
                  ),
                  title: Text(titleList[index]),
                  subtitle: Text(descriptionList[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
