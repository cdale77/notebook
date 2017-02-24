import React    from "react";

export default class NoteEditor extends React.Component {

  expanderClassName() {
    const base = "edit-note-form";
    if (this.props.display == true)
      return(base + " expanded");
    else
      return(base + " hidden");
  }

  render() {
    return(
      <div className={this.expanderClassName()} >
        Edit the note
      </div>
    )
  }
}

NoteEditor.propTypes = {
  note: React.PropTypes.object.isRequired
}
