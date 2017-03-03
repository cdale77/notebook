import expect               from "expect";
import Constants            from "../../../web/static/js/constants";
import noteReducer          from "../../../web/static/js/reducers/note_reducer";
import * as noteActions     from "../../../web/static/js/actions/notes";

describe("noteReducer", () => {

  it("should return the default state with no match", () => {
    const returnedState = noteReducer(undefined, {})
    expect(returnedState).toEqual({})
  })

  it("should handle GET_NOTES_SUCCESS", () => {
    const notes = [{name: "plans", note_html: "<h1>Plans</h1>"},
                   {name: "development", note_html: "<h1>Dev</h1"}];
    const returnedState = noteReducer(undefined, noteActions.getNotesSuccess(notes));
    expect(returnedState).toEqual({
      noteList: notes
    });
  })

  it("should handle GET_NOTES_FAILURE", () => {
    const returnedState = noteReducer({noteList: []}, noteActions.getNotesFailure());
    expect(returnedState).toEqual({noteList: []});
  })

  it("should handle NEW_NOTE_SUCCESS", () => {
    const notes = [{name: "foo", note_html: "<h1>foo</h1>"}];
    const newNote = {name: "bar", note_html: "<h1>bar</h1"};
    const returnedState = noteReducer({noteList: notes}, noteActions.newNoteSuccess(newNote));
    expect(returnedState).toEqual({
      noteList: notes
    });
  })

  it("should handle NEW_NOTE_FAILURE", () => {
    const returnedState = noteReducer({noteList: []}, noteActions.newNoteFailure());
    expect(returnedState).toEqual({noteList: []});
  })

  it("should handle SET_CURRENT_NOTE", () => {
    const note = {id: 2, name: "foo", note_html: "<h1>foo</h1>"}
    const note2 = {id: 3, name: "bar", note_html: "<h1>bar</h1>"}
    const notes = [note, note2];
    const returnedState = noteReducer({noteList: notes}, noteActions.setCurrentNote(note.id));
    expect(returnedState).toEqual({noteList: notes, currentNote: note })
  })

  it("should handle UPDATE_CURRENT_NOTE", () => {
    const note = {id: 2, name: "foo", note_html: "<h1>foo</h1>"}
    const note2 = {id: 3, name: "bar", note_html: "<h1>bar</h1>"}
    const notes = [note, note2];
    const initialState = {noteList: notes, currentNote: note};
    const newHtml = "<h1>baz</h1>";
    const returnedState = noteReducer(initialState, noteActions.updateCurrentNote(newHtml));

    const newValue = returnedState.currentNote.note_html
    expect(newValue).toEqual(newHtml)
  })
})
