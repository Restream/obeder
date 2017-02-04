class MenuSerializer < ActiveModel::Serializer
  attributes :id, :date
  has_many :menu_dishes
end
