import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/models/note.dart';
import 'package:manager_app/services/database_service.dart';
import 'Loading.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    Employee employee = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Notes",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List args = ["New Note", employee, null];
          Navigator.pushNamed(context, 'addOrEditNote', arguments: args);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[300],
      ),
      body: StreamBuilder<QuerySnapshot>(
        //will be a listview.builder stream
        stream: DatabaseServiceFirestore().getDocs(
            field: "employee",
            resultfield: employee.uid,
            collectionNamed: 'note'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading(); //widget loading
          }
          List<Note> notes = snapshot.data.docs.map((DocumentSnapshot e) {
            return Note.fromJson(e.data(), e.id);
          }).toList();

          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  onDismissed: (direction) {
                    DatabaseServiceFirestore().deleteDoc(
                        uid: notes[index].id, collectionName: "note");
                  },
                  child: ListTile(
                    trailing: TextButton(
                        onPressed: () {
                          List args = ["Edit Note", employee, notes[index].id];
                          Navigator.pushNamed(context, 'addOrEditNote',
                              arguments: args);
                        },
                        child: Icon(Icons.edit, color: Colors.grey)),
                    leading: Icon(Icons.book),
                    title: Text(notes[index].title),
                    isThreeLine: true,
                    subtitle: Text(notes[index].description),
                  ),
                  key: Key(employee.uid),
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
                );
              });
        },
      ),
    );
  }
}

class AddOrEditNote extends StatefulWidget {
  @override
  _AddOrEditNoteState createState() => _AddOrEditNoteState();
}

class _AddOrEditNoteState extends State<AddOrEditNote> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  Note note = Note();
  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context).settings.arguments;
    Employee employee = args[1];
    String title = args[0];
    note.id = args[2];
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width, //size of screen
          height: MediaQuery.of(context).size.height, //size of screen
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    controller: _titleController,
                    onSaved: (text) {
                      _titleController.text = text;
                    },
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
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    controller: _descriptionController,
                    onSaved: (text) {
                      _descriptionController.text = text;
                    },
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'a little description:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_validate()) return;
                        note.employee =
                            employee.uid; // add reference id of ceo to product
                        DatabaseServiceFirestore().setDoc(
                            collectionName: 'note',
                            instance: note,
                            uid: note.id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Confirm',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _validate() {
    if (_formKey.currentState.validate()) {
      note.title = _titleController.text;
      note.description = _descriptionController.text;
      return true;
    }
    return false;
  }
}
