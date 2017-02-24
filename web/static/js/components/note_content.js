import React   from "react";

export default class NoteContent extends React.Component {

  render() {
    return (
      <div className="note-content">
        {this.props.note.note_html}
      </div>
    )
  }
}

NoteContent.propTypes = {
  note: React.PropTypes.object.isRequired
}
