import React     from "react";
import Showdown  from "showdown";

export default class NoteContent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {converter: new Showdown.Converter()}
  }

  createMarkup() {
    return {__html: this.state.converter.makeHtml(this.props.note.note_html)}
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
