import Constants from "../constants";

function bookReducer(state = {}, action) {
  switch(action.type) {
    case Constants.ACTIONS.GET_BOOKS_SUCCESS:
      return Object.assign({}, state, {
        bookList: action.books
      })

    case Constants.ACTIONS.GET_BOOKS_FAILURE:
      return state

    case Constants.ACTIONS.NEW_BOOK_SUCCESS:
      const updatedBookList = state.bookList;
      updatedBookList.unshift(action.newBook);
      return Object.assign({}, state, {
        bookList: updatedBookList
      })

    case Constants.ACTIONS.NEW_BOOK_FAILURE:
      return state

    case Constants.ACTIONS.SET_CURRENT_BOOK:
      const currentBook = state.bookList.filter(function(book) {
        return parseInt(book.id) == parseInt(action.bookId)
      })[0];

      return Object.assign({}, state, {
        currentBook: currentBook
      })

    default:
      return state
  }
};

export default bookReducer
