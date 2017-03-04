import Constants              from "../constants";
import Utils                  from "../utils";
import Routes                 from "../routes";
import * as requestActions    from "./request";
import * as flashActions      from "./flash";

export function getNotesSuccess(notes) {
  return({
    type: Constants.ACTIONS.GET_NOTES_SUCCESS,
    notes: notes,
    sentAt: Date.now()
  });
}

export function getNotesFailure() {
  return({
    type: Constants.ACTIONS.GET_NOTES_FAILURE,
    sentAt: Date.now()
  });
}

export function newNoteSuccess(newNote) {
  return({
    type: Constants.ACTIONS.NEW_NOTE_SUCCESS,
    newNote: newNote,
    sentAt: Date.now()
  });
}

export function newNoteFailure() {
  return({
    type: Constants.ACTIONS.NEW_NOTE_FAILURE,
    sentAt: Date.now()
  });
}

export function setCurrentNote(noteId) {
  return({
    type: Constants.ACTIONS.SET_CURRENT_NOTE,
    noteId: noteId,
    sentAt: Date.now()
  });
}

export function updateCurrentNote(noteHtml) {
  return({
    type: Constants.ACTIONS.UPDATE_CURRENT_NOTE,
    noteHtml: noteHtml,
    sentAt: Date.now()
  })
}

/* Thunks */
const NoteActions = {

  getNotes: function(bookId) {
    return function(dispatch) {
      dispatch(requestActions.requestStart("GET_NOTES"));

      const requestOpts = Utils.makeRequestOptions("GET");
      const url = Routes.notes(bookId);

      fetch(url, requestOpts)
      .then((response) => {
        if (response.status == 200)
          return response.json()
        else
          throw "";
      })
      .then((json) => {
        dispatch(requestActions.requestEnd());
        dispatch(getNotesSuccess(json["data"]["notes"]));
      })
      .catch((message) => {
        dispatch(requestActions.requestEnd());
        dispatch(flashActions.flashError("Problem fetching notes: " + message));
        dispatch(getNotesFailure());
      });
    };
  },

  addNote: function(bookId, name) {
    return function(dispatch) {
      dispatch(requestActions.requestStart("NEW_NOTE"));

      const newNoteData = {note: {name: name}};
      const requestOpts = Utils.makeRequestOptions("POST", newNoteData);
      const url = Routes.notes(bookId);

      fetch(url, requestOpts)
      .then((response) => {
        if (response.status == 201)
          return response.json()
        else
          throw "Something went wrong";
      })
      .then((json) => {
        dispatch(requestActions.requestEnd());
        dispatch(newNoteSuccess(json["data"]["note"]))
      })
      .catch((message) => {
        dispatch(requestActions.requestEnd());
        dispatch(flashActions.flashError("Problem adding new note: " + message));
        dispatch(newNoteFailure());
      })
    }
  },

  updateNote: function(bookId, noteId, noteHtml) {
    return function(dispatch) {
      dispatch(requestActions.requestStart("NEW_NOTE"));
      const noteData = {note: {note_html: noteHtml}};
      const requestOpts = Utils.makeRequestOptions("PATCH", noteData);
      const url = Routes.note(bookId, noteId);

      fetch(url, requestOpts)
      .then((response) => {
        if(response.status == 200)
          return response.json()
        else
          throw "Something went wrong";
      })
      .then((json) => {
        dispatch(requestActions.requestEnd());
        // updating the state is done optimistically
      })
      .catch((message) => {
        dispatch(requestActions.requestEnd());
        dispatch(flashActions.flashError("Problem updating note: " + message));
      })
    }
  }
}

export default NoteActions
