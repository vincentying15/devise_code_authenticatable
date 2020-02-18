require "rails/generators"
require "rails/generators/active_record"

module DeviseCodeAuthenticatable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ::Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      def copy_locale
        copy_file '../../../../config/locales/en.yml', 'config/locales/devise_code_authenticatable.en.yml'
      end

      def copy_devise_migration
        migration_template 'migration.rb', "db/migrate/create_login_codes.rb", migration_version: migration_version
      end

      def migration_version
        major = ActiveRecord::VERSION::MAJOR
        if major >= 6
          "[#{major}.#{ActiveRecord::VERSION::MINOR}]"
        end
      end

      def self.next_migration_number(dirname)
        ::ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

    end
  end
end
