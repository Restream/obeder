# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## EZ deploy

Download and install the Heroku CLI. (brew install heroku or download pkg)
 * heroku login
 * heroku git:remote -a obeder

Deploy:
 * git push heroku master

## Add new user
```
user = User.create(name: 'ФАМИЛИЯ ИМЯ', email: 'EMAIL')
menus = Menu.ready.where('date >= ?', Date.current)

menus.each do |menu|
  user_menu = UserMenu.create(user: user, menu: menu, neem: user.neem)
  menu_dishes = menu.menu_dishes.default
  dishes = menu_dishes.map(&:dish)
  user_menu.dishes << dishes
end
```
