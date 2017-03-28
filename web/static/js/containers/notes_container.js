import React                from "react";
import { connect }          from "react-redux";
import { hashHistory }      from "react-router";
import noteThunks           from "../actions/notes";
import * as noteActions     from "../actions/notes";
import NoteList             from "../components/note_list";
import NoteView             from "../components/note_view";

const mapStateToProps = (state) => {
  return {
    session: state.session,
    notes: state.notes,
    books: state.books
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    getNotes: (bookId) => {
      dispatch(noteThunks.getNotes(bookId));
    },
    addNewNote: (bookId, name) => {
      dispatch(noteThunks.addNote(bookId, name));
    },
    setCurrentNote: (noteId) => {
      dispatch(noteActions.setCurrentNote(noteId));
    },
    updateCurrentNote: (bookId, noteId, noteHtml) => {
      dispatch(noteActions.updateCurrentNote(noteHtml));
      dispatch(noteThunks.updateNote(bookId, noteId, noteHtml));
    },
    clearNotes: () => {
      dispatch(noteActions.clearNotes());
    }
  }
}

class NotesContainer extends React.Component {

  constructor(props) {
    super(props);
    this.resetNoteData();
  }

  componentWillReceiveProps(nextProps) {
    if (this.props.books.currentBook.id != nextProps.books.currentBook.id) {
      this.resetNoteData();
    }
  }

  resetNoteData() {
    this.props.clearNotes();
    this.props.getNotes(this.props.books.currentBook.id);
  }

  render() {
    const bookId = this.props.notes.currentNote.book_id;
    if (this.props.session.signedIn == true)
      return (
        <div className="authenticated-container">
          <div className="notes-container">
            <NoteList book={this.props.books.currentBook}
              notes={this.props.notes.noteList}
              currentNote={this.props.notes.currentNote}
                      addNewNote={this.props.addNewNote}
                      setCurrentNote={this.props.setCurrentNote} />
            <NoteView note={this.props.notes.currentNote}
                      updateCurrentNote={this.props.updateCurrentNote.bind(this, bookId)} />
          </div>
        </div>
      );
    else
      return(<div>You need to be signed in to view this page</div>);
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(NotesContainer)
