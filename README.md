Google Book
===========

Google Book is a Ruby wrapper to the [Google Book Search Data API](http://code.google.com/apis/books/docs/gdata/developers_guide_protocol.html).

Usage
-----

    entries = Google::Book.search('deleuze')
    entry = entries.first

    puts entry.title
    => "Difference and repetition"
    puts entry.isbn
    => "9780826477156"
    puts entry.cover.thumbnail
    => "http://bks0.books.google.com/books?id=..."
