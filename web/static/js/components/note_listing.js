import React                    from "react";

export default class NoteListing extends React.Component {
  render() {
    return(
      <div className="note-listing"
           onClick={this.props.setCurrentNote.bind(this, this.props.note.id)} >
        <div className="note-name">{this.props.note.name}</div>
      </div>
    )
  }
}
