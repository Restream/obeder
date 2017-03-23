class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :neem, :description
end
