import React                from "react";
import BookListing          from "./book_listing";
import NewBookForm          from "./new_book_form";

export default class BookList extends React.Component {

  constructor(props) {
    super(props);
    this.state = {displayNewBookForm: false};
  }

  buildBookList() {
    return(
      this.props.books.bookList.map(function(book) {
        return(<BookListing key={book.id} book={book} />)
      })
    )
  }

  render() {
    return(
      <div>
        <h1>Books</h1>
        <NewBookForm onSubmit={this.props.addNewBook} />
        <table className="site-list table-minimal">
          <tbody>
            <tr>
              <th>Name</th>
              <th></th>
            </tr>
            {this.buildBookList()}
          </tbody>
        </table>
      </div>
    )
  }
}

BookList.propTypes = {
  books: React.PropTypes.object.isRequired
}
