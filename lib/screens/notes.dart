import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/services/constantes.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    final suggestionList = [
      ["something", "theres is nothing"],
      ["two", "hi"],
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Notes",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Wrap(
                direction: Axis.vertical,
                children: [
                  AlertDialog(
                    contentPadding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                    titlePadding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 30, right: 10),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                    title: Text(
                      "New Note",
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (text) {},
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'title:',
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            maxLines: 5,
                            onChanged: (text) {},
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              labelText: 'A little description:',
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[300],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) {},
          child: ListTile(
            trailing: TextButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return Wrap(
                        direction: Axis.vertical,
                        children: [
                          AlertDialog(
                            contentPadding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 5, right: 5),
                            titlePadding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 30, right: 10),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                            ],
                            title: Text(
                              "Edit Note",
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    onChanged: (text) {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      labelText: 'title:',
                                      labelStyle: TextStyle(fontSize: 15),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    maxLines: 5,
                                    onChanged: (text) {},
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      labelText: 'A little description:',
                                      labelStyle: TextStyle(fontSize: 15),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.edit, color: Colors.grey)),
            leading: Icon(Icons.book),
            title: Text(suggestionList[index][0]),
            isThreeLine: true,
            subtitle: Text(suggestionList[index][1]),
          ),
          key: Key("4"),
          background: Container(
            color: Colors.red[300],
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.delete),
                  Icon(Icons.delete),
                ],
              ),
            ),
          ),
        ),
        itemCount: suggestionList.length,
      ),
    );
  }
}
