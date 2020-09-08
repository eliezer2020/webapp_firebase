import 'package:flutter/cupertino.dart';
import 'package:web_app/models/note_model.dart';

class NoteController extends ChangeNotifier {
  bool editing = false;
  TextEditingController myController = new TextEditingController();
  Note selectedNote;
  @override
  void removeListener(void Function() listener) {
    // TODO: implement removeListener
    super.removeListener(listener);
  }

  //Edit Button
  void enableEditing() {
    editing = (editing == true) ? false : true;
    notifyListeners();
  }

  //onNote selected
  void onNoteSelected(Note note) {
    editing = false;
    selectedNote = note;
    myController.text = note.body;
    print("Note: " + note.title);
    notifyListeners();
  }

  Note getSelectedNote() => this.selectedNote;
}
