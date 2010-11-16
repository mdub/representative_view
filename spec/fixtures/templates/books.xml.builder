xml.books do
  @books.each do |book|
    xml.title(book.title)
  end
end
