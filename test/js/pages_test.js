import expect                   from "expect";
import Pages                    from "../../web/static/js/pages";

describe("Pages", () => {

  it("should return the proper sign in page", () => {
    expect("/sign_in").toEqual(Pages.signIn());
  })

  it("should return the proper books page", () => {
    expect("/books").toEqual(Pages.books());
  })

  it("should return the proper book page", () => {
    const bookId = 4;
    expect("/books/4").toEqual(Pages.book(bookId));
  })

  it("should return the proper notes page", () => {
    const bookId = 3;
    expect("/books/3/notes").toEqual(Pages.notes(bookId));
  })

  it("should return the proper note page", () => {
    const bookId = 4;
    const noteId = 12;
    expect("/books/4/notes/12").toEqual(Pages.note(bookId, noteId));
  })
})
