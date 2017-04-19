class CookPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError.new(policy: 'cook') if (user.blank? || user.role.user?)
  end

  def method_missing(name, *args)
    true
  end
end
