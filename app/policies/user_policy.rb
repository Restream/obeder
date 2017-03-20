class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError.new(policy: 'user'), 'must be logged in' unless user
  end

  def method_missing(name, *args)
    true
  end
end
