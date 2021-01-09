# frozen_string_literal: true

class AddEmailToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string, unique: true
  end
end
