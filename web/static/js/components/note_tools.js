import React                from "react";

export default class NoteTools extends React.Component {

  render() {
    return(
      <div className="note-tools">
        <div className="note-buttons">
          <button onClick={this.props.toggleEditor}>
            Edit
          </button>
        </div>
      </div>
    )
  }
}
