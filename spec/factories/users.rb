# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  activated         :boolean          default(FALSE)
#  activation_digest :string(255)
#  admin             :boolean          default(FALSE)
#  email             :string(255)
#  name              :string(255)
#  password_digest   :string(255)
#  remember_digest   :string(255)
#  reset_digest      :string(255)
#  reset_sent_at     :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :user do
    name { 'factory' }
    email { 'factory@example.com' }
    password { 'password' }
    admin { true }
  end

  factory :other_user, class: User do
    name { 'sampleuser' }
    email { 'sample@example.fom' }
    password { 'foobar' }
  end
end
