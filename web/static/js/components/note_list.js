import React                  from "react";
import NoteListing            from "./note_listing";
import NewNoteForm            from "./new_note_form";

export default class NoteList extends React.Component {

  buildNoteList() {
    const sortedNotes = this.props.notes.sort((a,b) => {
      return(a.updated_at < b.updated_at);
    })

    return(
      sortedNotes.map(function(note) {
        return(<NoteListing key={note.id}
                            note={note}
                            currentNote={this.props.currentNote}
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
