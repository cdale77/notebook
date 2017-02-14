const Pages = {

  signIn: () => { return("/sign_in") },

  books: () => { return("/books") },

  book: (bookId) => { return("/books/" + bookId) }

}

export default Pages;
