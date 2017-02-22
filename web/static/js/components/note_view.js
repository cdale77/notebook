import React                     from "react";
import NoteEditor                from "./note_editor";

export default class NoteView extends React.Component {
  render() {
    return(
      <div className="note-view">
        <h2 className="note-title">{this.props.note.name}</h2>
        <NoteEditor note={this.props.note} />
      </div>
    )
  }
}
