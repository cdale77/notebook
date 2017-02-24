import React    from "react";

export default class NoteEditor extends React.Component {

  constructor(props) {
    super(props);
    const timestamp = new Date().getTime();
    this.state = {lastSaved: timestamp, lastKeystroke: timestamp};
  }

  expanderClassName() {
    const base = "edit-note-form";
    if (this.props.display == true)
      return(base + " expanded");
    else
      return(base + " hidden");
  }

  saveNote(e) {
    const timestamp = new Date().getTime();
    const diff = timestamp - this.state.lastSaved;
    console.log(diff);
    if (diff > 3000) {
      console.log("save");
    }
    this.setState({lastSaved: timestamp});
  }

  processKeystroke(e) {
    this.setState({lastKeystroke: new Date().getTime()});
    this.saveNote(e);
  }

  render() {
    return(
      <div className={this.expanderClassName()} >
        <form onKeyUp={this.processKeystroke.bind(this)} >
          <textarea name="note_html" id="note_html"></textarea>
        </form>
      </div>
    )
  }
}

NoteEditor.propTypes = {
  note: React.PropTypes.object.isRequired
}
