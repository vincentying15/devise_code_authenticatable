# DeviseCodeAuthenticatable
A Devise plugin for two-factor authenticatable.

## Installation
Add this line to your Rails Gemfile:

```ruby
gem 'devise_code_authenticatable'
```

Run:

```bash
rails generate devise_code_authenticatable:install
```

This will create a migration file in your `db/migrate` folder, then


```ruby
rails db:migrate
```
Add `:authenticatable` to the model you want to enable code_authenticatable, also make sure `:database_authenticatable` is removed

```ruby
class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :code_authenticatable
end
```
## Usage
### Customize views
This plugin is included with basic views, to customize the views you need to run

```bash
rails generate devise_code_authenticatable:views
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
