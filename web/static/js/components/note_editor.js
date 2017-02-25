import React    from "react";

export default class NoteEditor extends React.Component {

  constructor(props) {
    super(props);
    const timestamp = new Date().getTime();
    this.state = {
      lastSaved: timestamp,
      lastKeystroke: timestamp,
      displaySaveIcon: false
    };
  }

  componentWillUnmount() {
    this.clearTimers();
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.display == true) {
      const saveTimer = window.setInterval(() => { this.saveNote() }, 3000);
      this.setState({saveTimer: saveTimer});
    } else if (nextProps.display == false) {
      this.clearTimers();
    }
  }

  clearTimers() {
    window.clearTimeout(this.state.saveTimer);
    window.clearTimeout(this.state.iconTimer);
  }

  expanderClassName() {
    const base = "edit-note-form";
    if (this.props.display == true)
      return(base + " expanded");
    else
      return(base + " hidden");
  }

  saveNote() {
    const diff = this.state.lastKeystroke - this.state.lastSaved;
    if (diff > 0) {
      // fire an action to save the note to the server, which will update the
      // global state
      this.setState({lastSaved: new Date().getTime()});
      this.showSaveIcon();
    }
  }

  processKeystroke() {
    this.setState({lastKeystroke: new Date().getTime()});
  }

  showSaveIcon() {
    const iconTimer = window.setTimeout(() => {
      this.setState({displaySaveIcon: false});
    }, 2000)
    this.setState({displaySaveIcon: true, iconTimer: iconTimer});
  }

  saveIconClass() {
    if (this.state.displaySaveIcon == false)
      return("hidden")
  }

  render() {
    return(
      <div className={this.expanderClassName()} >
        <div className="editor-top">
          <div className={"save-icon " + this.saveIconClass()}>
            Saved
          </div>
        </div>
        <form onKeyUp={this.processKeystroke.bind(this)} >
          <textarea name="note_html" id="note_html"></textarea>
        </form>
      </div>
    );
  }
}

NoteEditor.propTypes = {
  note: React.PropTypes.object.isRequired
}
