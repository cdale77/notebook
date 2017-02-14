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
})
