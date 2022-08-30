# README
## Description 
A reading list app made in Ruby on Rails framework. It has the ability to add, update, and delete both authors and books. There are additional features such as sorting books in alphabetical order, sorting authors by number of books, displaying only books that are in print, and displaying books based on a specified length.
## Design
The reading_list database has two tables, authors and books. This is a one to many relationship, where an author has many books and a book has only one author. The tables are linked via the foreign key author_id on the books table.
![Schema](https://user-images.githubusercontent.com/99758586/187223232-814a4862-a5c7-428c-a283-dc3126a8a167.png)

https://dbdesigner.page.link/pscS1fLPPvBjnynZA

### Required versions
- Ruby version 2.7.4
- Rails version 5.2.8

## Instructions
- Fork this repository
- Clone your forked repository
- Ensure your ruby and rails version match the required versions for this app
- Run `bundle install`
- Run `rails db:{drop,create,migrate,seed}`
- Run `rails server`




