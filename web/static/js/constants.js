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
    routing: {}
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
  }
}

export default Constants
