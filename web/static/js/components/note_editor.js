import React    from "react";

export default class NoteEditor extends React.Component {

  expanderClassName() {
    const base = "edit-note-form";
    if (this.props.display == true)
      return(base);
    else
      return(base + " hidden");
  }

  render() {
    return(
      <div className="edit-note-form">
        <div className={this.expanderClassName()} >
          Edit the note
        </div>
      </div>
    )
  }
}

NoteEditor.propTypes = {
  note: React.PropTypes.object.isRequired
}
