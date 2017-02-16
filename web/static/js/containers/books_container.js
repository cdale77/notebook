import React                from "react";
import { connect }          from "react-redux";
import { hashHistory }      from "react-router";
import bookThunks           from "../actions/books";
import * as bookActions     from "../actions/books";
import BookList             from "../components/book_list";
import Pages                from "../pages";

const mapStateToProps = (state) => {
  return { session: state.session, books: state.books }
}

const mapDispatchToProps = (dispatch) => {
  return {
    getBooks: () => {
      dispatch(bookThunks.getBooks());
    },
    addNewBook: (name) => {
      dispatch(bookThunks.addBook(name));
    },
    setCurrentBook: (bookId) => {
      dispatch(bookActions.setCurrentBook(bookId));
      hashHistory.push(Pages.notes(bookId));
    }
  }
}

class BooksContainer extends React.Component {

  componentWillMount() {
    this.props.getBooks();
  }

  render() {
    if (this.props.session.signedIn == true)
      return (
        <div className="authenticated-container">
          <BookList addNewBook={this.props.addNewBook}
                    setCurrentBook={this.props.setCurrentBook}
                    books={this.props.books} />
        </div>
      );
    else
      return(<div>You need to be signed in to view this page</div>);
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(BooksContainer)
