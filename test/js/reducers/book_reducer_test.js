import expect               from "expect";
import Constants            from "../../../web/static/js/constants";
import bookReducer          from "../../../web/static/js/reducers/book_reducer";
import * as bookActions     from "../../../web/static/js/actions/books";

describe("bookReducer", () => {

  it("should return the default state with no match", () => {
    const returnedState = bookReducer(undefined, {})
    expect(returnedState).toEqual({})
  })

  it("should handle GET_BOOKS_SUCCESS", () => {
    const books = [{name: "foo.com"}];
    const returnedState = bookReducer(undefined, bookActions.getBooksSuccess(books));
    expect(returnedState).toEqual({
      bookList: books
    });
  })

  it("should handle GET_BOOKS_FAILURE", () => {
    const returnedState = bookReducer({bookList: []}, bookActions.getBooksFailure());
    expect(returnedState).toEqual({bookList: []});
  })

  it("should handle NEW_BOOK_SUCCESS", () => {
    const books = [{name: "foo"}];
    const newBook = {name: "bar"};
    const returnedState = bookReducer({bookList: books}, bookActions.newBookSuccess(newBook));
    expect(returnedState).toEqual({
      bookList: books
    });
  })

  it("should handle NEW_BOOK_FAILURE", () => {
    const returnedState = bookReducer({bookList: []}, bookActions.newBookFailure());
    expect(returnedState).toEqual({bookList: []});
  })

  it("should handle SET_CURRENT_BOOK", () => {
    const book = {id: 2, name: "foo"}
    const book2 = {id: 3, name: "bar"}
    const books = [book, book2];
    const returnedState = bookReducer({bookList: books}, bookActions.setCurrentBook(book.id));
    expect(returnedState).toEqual({bookList: books, currentBook: book })
  })

})
