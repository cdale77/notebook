import React      from "react";
import Pages      from "../pages";
import { Link }   from "react-router";

export default class BookListing extends React.Component {
  render() {
    return(
      <tr className="book">
        <td>{this.props.book.name}</td>
        <td>
          <Link to={Pages.book(this.props.book.id)} className="book-link" >
            <button>Notes</button>
          </Link>
        </td>
      </tr>
    );
  }
}

BookListing.propTypes = {
  book: React.PropTypes.object.isRequired
};
