import Constants from "../constants";

function noteReducer(state = {}, action) {
  switch(action.type) {
    case Constants.ACTIONS.GET_NOTES_SUCCESS:
      return Object.assign({}, state, {
        noteList: action.notes
      })

    case Constants.ACTIONS.GET_NOTES_FAILURE:
      return state

    case Constants.ACTIONS.NEW_NOTE_SUCCESS:
      const updatedNoteList = state.noteList;
      updatedNoteList.unshift(action.newNote);
      return Object.assign({}, state, {
        noteList: updatedNoteList
      })

    case Constants.ACTIONS.NEW_NOTE_FAILURE:
      return state

    case Constants.ACTIONS.SET_CURRENT_NOTE:
      const currentNote = state.noteList.filter(function(note) {
        return parseInt(note.id) == parseInt(action.noteId)
      })[0];

      return Object.assign({}, state, {
        currentNote: currentNote
      })

    case Constants.ACTIONS.UPDATE_CURRENT_NOTE:
      const newNote = state.currentNote;
      newNote.note_html = action.noteHtml;

      return Object.assign({}, state, {
        currentNote: newNote
      })

    case Constants.ACTIONS.CLEAR_NOTES:
      return Object.assign({}, state, {
        noteList: [],
        currentNote: {}
      })

    default:
      return state
  }
};

export default noteReducer
