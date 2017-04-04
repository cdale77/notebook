import React                from "react";

export default class NoteTools extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      displayTools: false
    }
  }

  noteToolsClassName() {
    const base = "note-tools";
    if (this.props.noteName)
      return(base);
    else
      return(base + " hidden");
  }

  render() {
    return(
      <div className={this.noteToolsClassName()}>
        <div className="note-buttons">
          <button onClick={this.props.toggleEditor}>
            Edit
          </button>
        </div>
        <div className="note-name">{this.props.noteName}</div>
      </div>
    )
  }
}
