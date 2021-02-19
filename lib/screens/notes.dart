import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/models/employee.dart';
import 'package:manager_app/models/note.dart';
import 'package:manager_app/services/constantes.dart';
import 'package:manager_app/services/database_service.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    Employee employee = ModalRoute.of(context).settings.arguments;
    DocumentReference refEmployee = DatabaseServiceFirestore().getRef(
      collectionNamed: 'employee',
      uid: employee.uid,
    );
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
        stream: DatabaseServiceFirestore().getDocs(
            field: "employee",
            resultfield: refEmployee,
            collectionNamed: 'note'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ConstantesWidgets.loading(); //widget loading
          }
          List<Note> notes = snapshot.data.docs.map((DocumentSnapshot e) {
            return Note.fromJson(e.data(), e.id);
          }).toList();

          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                Note note = notes[index];
                return Dismissible(
                  onDismissed: (direction) {
                    DatabaseServiceFirestore()
                        .deleteDoc(uid: note.id, collectionName: "note");
                  },
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        ConstantesWidgets.dialog(
                          context: context,
                          title: Wrap(
                            children: [Text('${note.title}')],
                          ),
                          content: Wrap(
                            children: [Text(note.description)],
                          ),
                          actions: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Ok'),
                          ),
                        );
                      },
                      trailing: TextButton(
                          onPressed: () {
                            List args = ["Edit Note", employee, note];
                            Navigator.pushNamed(context, 'addOrEditNote',
                                arguments: args);
                          },
                          child: Icon(Icons.edit, color: Colors.grey)),
                      leading: Icon(Icons.book),
                      title: Text(note.title),
                      isThreeLine: true,
                      subtitle: Text(note.description.substring(
                          0,
                          note.description.length >= 10
                              ? 10
                              : note.description.length)),
                    ),
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
  Note note;

  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context).settings.arguments;
    Employee employee = args[1];
    String title = args[0];
    note = args[2] == null ? Note() : args[2];

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
                    initialValue: note.title == null ? '' : note.title,
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (text) {
                      note.title = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Title:',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue:
                        note.description == null ? '' : note.description,
                    validator: (String value) {
                      return value.isEmpty ? 'Required field.' : null;
                    },
                    onChanged: (text) {
                      note.description = text;
                    },
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'A little description:',
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
                        DocumentReference refEmployee =
                            DatabaseServiceFirestore().getRef(
                          collectionNamed: 'employee',
                          uid: employee.uid,
                        );
                        note.employee = refEmployee;

                        DatabaseServiceFirestore().setDoc(
                            collectionName: 'note',
                            instance: note,
                            uid: note.id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        title == 'New Note' ? 'Create Note' : 'Confirm',
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
      if (note.title == null) note.title = '';
      if (note.description == null) note.description = '';
      return true;
    }
    return false;
  }
}
