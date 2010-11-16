xml.books(:type => "array") do
  @books.each do |book|
    xml.book do
      xml.title(book.title)
    end
  end
end
