class CreateLoginCodes < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :login_codes do |t|
      t.string :code
      t.integer :retry_times
      t.boolean :expired
      t.references :resource, polymorphic: true, index: true

      t.timestamps
    end
  end
end
