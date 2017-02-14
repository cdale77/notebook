import Constants              from "../constants";
import Utils                  from "../utils";
import Routes                 from "../routes";
import * as requestActions    from "./request";
import * as flashActions      from "./flash";

export function getBooksSuccess(books) {
  return({
    type: Constants.ACTIONS.GET_BOOKS_SUCCESS,
    books: books,
    sentAt: Date.now()
  });
}

export function getBooksFailure() {
  return({
    type: Constants.ACTIONS.GET_BOOKS_FAILURE,
    sentAt: Date.now()
  });
}

export function newBookSuccess(newBook) {
  return({
    type: Constants.ACTIONS.NEW_BOOK_SUCCESS,
    newBook: newBook,
    sentAt: Date.now()
  });
}

export function newBookFailure() {
  return({
    type: Constants.ACTIONS.NEW_BOOK_FAILURE,
    sentAt: Date.now()
  });
}

export function setCurrentBook(bookId) {
  return({
    type: Constants.ACTIONS.SET_CURRENT_BOOK,
    bookId: bookId,
    sentAt: Date.now()
  });
}

/* Thunks */
const BookActions = {

  getBooks: function() {
    return function(dispatch) {
      dispatch(requestActions.requestStart("GET_BOOKS"));

      const requestOpts = Utils.makeRequestOptions("GET");
      const url = Routes.books();

      fetch(url, requestOpts)
      .then((response) => {
        if (response.status == 200)
          return response.json()
        else
          throw "";
      })
      .then((json) => {
        dispatch(requestActions.requestEnd());
        dispatch(getBooksSuccess(json["data"]["books"]));
      })
      .catch((message) => {
        dispatch(requestActions.requestEnd());
        dispatch(flashActions.flashError("Problem fetching books: " + message));
        dispatch(getBooksFailure());
      });
    };
  },

  addBook: function(name) {
    return function(dispatch) {
      dispatch(requestActions.requestStart("NEW_BOOK"));

      const newBookData = {book: {name: name}};
      const requestOpts = Utils.makeRequestOptions("POST", newBookData);
      const url = Routes.books();

      fetch(url, requestOpts)
      .then((response) => {
        if (response.status == 201)
          return response.json()
        else
          throw "Something went wrong";
      })
      .then((json) => {
        dispatch(requestActions.requestEnd());
        dispatch(newBookSuccess(json["data"]["book"]))
      })
      .catch((message) => {
        dispatch(requestActions.requestEnd());
        dispatch(flashActions.flashError("Problem adding new book: " + message));
        dispatch(newBookFailure());
      })
    }
  }
}

export default BookActions
