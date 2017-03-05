import React                    from "react";

export default class NoteListing extends React.Component {

  buildClassName() {
    if(this.props.note.id == this.props.currentNote.id)
      return("note-listing selected");
    else
      return("note-listing")
  }
  render() {
    return(
      <div className={this.buildClassName()}
           onClick={this.props.setCurrentNote.bind(this, this.props.note.id)} >
        <div className="note-name">{this.props.note.name}</div>
      </div>
    )
  }
}
