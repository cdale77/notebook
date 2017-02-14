import expect                   from "expect";
import Routes                   from "../../web/static/js/routes";

describe("Routes", () => {

  it("should return the proper session route", () => {
    expect(Routes.session()).toEqual("/api/v1/sessions");
  })

  it("should return the proper currentUser route", () => {
    expect(Routes.currentUser()).toEqual("/api/v1/current_user");
  })

  it("should return the proper books route", () => {
    expect(Routes.books()).toEqual("/api/v1/books");
  })
})
