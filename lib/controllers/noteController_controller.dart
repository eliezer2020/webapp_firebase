import 'package:flutter/cupertino.dart';
import 'package:web_app/models/note_model.dart';

class NoteController extends ChangeNotifier {
  bool editing = false;
  TextEditingController myController = new TextEditingController();
  Note selectedNote;

  //Edit Button
  void enableEditing() {
    editing = (editing == true) ? false : true;
    notifyListeners();
  }

  //onNote selected
  void setSelectedNote(Note note) {
    editing = false;
    selectedNote = note;
    myController.text = note.body;
    print("Note: " + note.title);
    notifyListeners();
  }

  Note getSelectedNote() => this.selectedNote;

  void disposeNoteController() {
    this.myController.clear();
  }
}
