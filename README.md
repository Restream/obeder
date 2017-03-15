# README

## Setup

 * docker-compose up
 * docker-compose exec web yarn
 * docker-compose exec web yarn build

## EZ deploy

Download and install the Heroku CLI. (brew install heroku or download pkg)
 * heroku login
 * heroku git:remote -a obeder

Deploy:
 * heroku buildpacks:add heroku/nodejs
 * heroku buildpacks:add heroku/ruby
 * heroku config:set NPM_CONFIG_PRODUCTION=false
 * heroku addons:create heroku-postgresql:hobby-dev
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
