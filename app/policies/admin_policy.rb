class AdminPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError.new(policy: 'admin') if (user.blank? || !user.role.admin?)
  end

  def method_missing(name, *args)
    true
  end
end
