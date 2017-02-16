import React      from "react";

export default class NewNoteForm extends React.Component {

  constructor(props) {
    super(props);
    this.state = {expanded: false};
  }

  toggleExpander() {
    this.setState({expanded: !this.state.expanded});
  }

  expanderClassName() {
    const base = "expander-trigger new-note-form-expander";
    if (this.state.expanded == true)
      return(base);
    else
      return(base + " expander-hidden");
  }

  onSubmit(e) {
    e.preventDefault();
    this.props.onSubmit(this.props.bookId, e.target.name.value);
    this.setState({expanded: false});
  }

  render() {
    return(
      <div className="expander">
        <button
          onClick={this.toggleExpander.bind(this)}
          className={"new-note-expander " + this.expanderClassName()}>
          + Add Note
        </button>
        <div className="form fieldset new-note-form expander-content">
          <form onSubmit={this.onSubmit.bind(this)}>
            <label htmlFor="name">Name</label>
            <input name="name" id="name" type="text" />
            <input className="button" name="submit" id="submit" type="submit" value="Add" />
          </form>
        </div>
      </div>
    )
  }
}
