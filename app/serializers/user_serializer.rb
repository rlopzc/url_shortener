# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_key         :string
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :api_key
end
