import React   from "react";
import Marked  from "marked";

export default class NoteContent extends React.Component {

  createMarkup() {
    return {__html: Marked(this.props.note.note_html)}
  }

  render() {
    return (
      <div className="note-content"
           dangerouslySetInnerHTML={this.createMarkup()} >
      </div>
    )
  }
}

NoteContent.propTypes = {
  note: React.PropTypes.object.isRequired
}
