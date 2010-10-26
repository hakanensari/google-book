Google Book
===========

Google Book is a work-in-progress Ruby class in tight embrace with the [Google Book Search Data API](http://code.google.com/apis/books/docs/gdata/developers_guide_protocol.html).

    books = GoogleBook.find('deleuze')
    
    book = books.first
    book.title
    => "Foucault"
    book.isbn
    => "9780826490780"

Paginate through the result set, sort of.

    GoogleBook.find('deleuze', :page => 2, :count => 20)
