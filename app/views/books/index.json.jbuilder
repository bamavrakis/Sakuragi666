json.array!(@books) do |book|
  json.extract! book, :id, :name, :popularity, :private
  json.url book_url(book, format: :json)
end
