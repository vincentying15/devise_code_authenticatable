# DeviseCodeAuthenticatable
A Devise plugin for two-factor authenticatable.

## Demo
An example rails app to use this plugin is setup in [demo](https://github.com/vincentying15/demo_for_devise_code_authenticatable)

## Installation
Add this line to your Rails Gemfile:

```ruby
gem 'devise_code_authenticatable'
```

### Automatic installation
Run:

```bash
rails generate devise_code_authenticatable:install
```

This will create a migration file name in your <tt>db/migrate</tt> folder, then
 

```ruby
rails db:migrate
```
### Devise Configuration
Add <tt>:authenticatable</tt> to the model you want to enable code_authenticatable

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

### Login by password
The existing <tt>Devise::SessionsController</tt> would be override, so you can not login by your password 

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
