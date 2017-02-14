import React      from "react";
import Pages      from "../pages";

export default class BookListing extends React.Component {
  render() {
    return(
      <div className="book-listing">
        <div className="book-name">{this.props.book.name}</div>
        <div className="book-notes">x notes</div>
      </div>
    );
  }
}

BookListing.propTypes = {
  book: React.PropTypes.object.isRequired
};
