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
        return(<BookListing key={book.id}
                            book={book}
                            setCurrentBook={this.props.setCurrentBook} />)
      }.bind(this))
    )
  }

  render() {
    return(
      <div className="book-list-container">
        <h1>Books</h1>
        <NewBookForm onSubmit={this.props.addNewBook} />
        <div className="book-list">{this.buildBookList()}</div>
      </div>
    )
  }
}

BookList.propTypes = {
  books: React.PropTypes.object.isRequired,
  addNewBook: React.PropTypes.func.isRequired
}
