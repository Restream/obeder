class CookPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError.new(policy: 'cook'), 'must be logged in' if (user.nil? || user.role.user?)
  end

  def method_missing(name, *args)
    true
  end

end
