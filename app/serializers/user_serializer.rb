class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :neem, :description
end
