SELECT books.title, authors.name, reviews.rating
FROM books
INNER JOIN authors
ON books.author_id = authors.id
INNER JOIN reviews
ON books.id = reviews.book_id
WHERE books.author_id = reviews.reviewer_id;