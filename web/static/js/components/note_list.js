import React                  from "react";
import NoteListing            from "./note_listing";
import NewNoteForm            from "./new_note_form";

export default class NoteList extends React.Component {

  buildNoteList() {
    return(
      this.props.notes.map(function(note) {
        return(<NoteListing key={note.id}
                            note={note}
                            setCurrentNote={this.props.setCurrentNote} />)
      }.bind(this))
    )
  }

  render() {
    return(
      <div className="note-list">
        <NewNoteForm
          bookId={this.props.book.id}
          onSubmit={this.props.addNewNote} />
        <div className="note-tiles">{this.buildNoteList()}</div>
      </div>
    )
  }
}

NoteList.propTypes = {
  notes: React.PropTypes.array.isRequired,
  addNewNote: React.PropTypes.func.isRequired
}
