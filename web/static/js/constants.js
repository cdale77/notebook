const Constants = {
  DEFAULT_STATE: {
    flash: {
      flashType: "",
      message: ""
    },
    session: {
      signedIn: false,
      user: {}
    },
    routing: {},
    books: {
      currentBook: {},
      bookList: []
    },
    notes: {
      currentNote: {},
      noteList: []
    }
  },
  ACTIONS: {
    REQUEST_START:                "REQUEST_START",
    REQUEST_END:                  "REQUEST_END",
    FLASH_SUCCESS:                "FLASH_SUCCESS",
    FLASH_ERROR:                  "FLASH_ERROR",
    FLASH_CLEAR:                  "FLASH_CLEAR",
    NEW_SESSION_SUCCESS:          "NEW_SESSION_SUCCESS",
    NEW_SESSION_FAILURE:          "NEW_SESSION_FAILURE",
    DESTROY_SESSION_SUCCESS:      "DESTROY_SESSION_SUCCESS",
    DESTROY_SESSION_FAILURE:      "DESTROY_SESSION_FAILURE",
    NEW_BOOK_SUCCESS:             "NEW_BOOK_SUCCESS",
    NEW_BOOK_FAILURE:             "NEW_BOOK_FAILURE",
    GET_BOOKS_SUCCESS:            "GET_BOOKS_SUCCESS",
    GET_BOOKS_FAILURE:            "GET_BOOKS_FAILURE",
    SET_CURRENT_BOOK:             "SET_CURRENT_BOOK",
    NEW_NOTE_SUCCESS:             "NEW_NOTE_SUCCESS",
    NEW_NOTE_FAILURE:             "NEW_NOTE_FAILURE",
    GET_NOTES_SUCCESS:            "GET_NOTES_SUCCESS",
    GET_NOTES_FAILURE:            "GET_NOTES_FAILURE",
    SET_CURRENT_NOTE:             "SET_CURRENT_NOTE",
    UPDATE_CURRENT_NOTE:          "UPDATE_CURRENT_NOTE"
  }
}

export default Constants
