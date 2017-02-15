const Pages = {

  signIn: () => { return("/sign_in") },

  books: () => { return("/books") },

  book: (bookId) => { return("/books/" + bookId) },

  notes: (bookId) => { return("/books/" + bookId + "/notes") },

  note: (bookId, noteId) => { return("/books/" + bookId + "/notes/" + noteId)}

}

export default Pages;
