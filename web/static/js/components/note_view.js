import React                     from "react";
import NoteEditor                from "./note_editor";
import NoteContent               from "./note_content";
import NoteTools                 from "./note_tools";

export default class NoteView extends React.Component {

  constructor(props) {
    super(props);
    this.state = {displayEditor: false};
  }

  toggleEditor() {
    this.setState({displayEditor: !this.state.displayEditor});
  }

  render() {
    return(
      <div className="note-view">
        <NoteTools toggleEditor={this.toggleEditor.bind(this)} />
        <div className="note-pane">
          <NoteEditor note={this.props.note}
                      display={this.state.displayEditor}
                      updateCurrentNote={this.props.updateCurrentNote} />
          <NoteContent note={this.props.note} />
        </div>
      </div>
    )
  }
}
