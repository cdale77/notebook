const Routes = {

  session: () => { return("/api/v1/sessions"); },

  currentUser: () => { return("/api/v1/current_user"); },

  books: () => { return("/api/v1/books"); },

  notes: (bookId) => { return("/api/v1/books/" + bookId + "/notes") },

  note: (bookId, noteId) => { return("/api/v1/books/" + bookId + "/notes/" + noteId) }

};

export default Routes;
