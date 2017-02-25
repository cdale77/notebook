import React from "react";

export default class NewBookForm extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      expanded: false,
      newBookName: "",
    };
  }

  toggleExpander() {
    this.setState({expanded: !this.state.expanded})
  }

  expanderClassName() {
    const base = "expander-trigger new-book-form-expander";
    if (this.state.expanded == true)
      return(base);
    else
      return(base + " expander-hidden");
  }

  handleChange(e) {
    this.setState({newBookName: e.target.value});
  }

  onSubmit(e) {
    e.preventDefault();
    this.props.onSubmit(this.state.newBookName);
    this.setState({expanded: false})
  }

  render() {
    return(
      <div className="expander">
        <button
          onClick={this.toggleExpander.bind(this)}
          className={"new-book-expander " + this.expanderClassName()}>
          + Add Book
        </button>
        <div className="form fieldset new-book-form expander-content">
          <form onSubmit={this.onSubmit.bind(this) }>
            <label htmlFor="name">Name</label>
            <input name="name"
                   id="name"
                   type="text"
                   value={this.state.value}
                   onChange={this.handleChange.bind(this)} />
            <input className="button"
                   name="submit"
                   id="submit"
                   type="submit"
                   value="Add" />
          </form>
        </div>
      </div>
    )
  }
}

NewBookForm.propTypes = {
  expanded: React.PropTypes.bool,
  onSubmit: React.PropTypes.func.isRequired
}
