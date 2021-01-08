# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  remember_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :user do
    name { "factory" }
    email {"factory@example.com" }
    password { "password" }
  end

  factory :other_user, class: User do
    name { "sampleuser" }
    email { "sample@example.fom" }
    password { "foobar" }
  end
end
