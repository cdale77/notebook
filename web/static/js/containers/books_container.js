import React                from "react";
import { connect }          from "react-redux";
import bookActions          from "../actions/books";
import BookList             from "../components/book_list";

const mapStateToProps = (state) => {
  return { session: state.session, books: state.books }
}

const mapDispatchToProps = (dispatch) => {
  return {
    getBooks: () => {
      dispatch(bookActions.getBooks());
    },
    addNewBook: (name) => {
      dispatch(bookActions.addBook(name));
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
                    books={this.props.books} />
        </div>
      );
    else
      return(<div>You need to be signed in to view this page</div>);
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(BooksContainer)
