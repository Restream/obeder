module UserRepository
  extend ActiveSupport::Concern
  included do
    scope :without_role, -> (role) { where.not(role: role) }
  end
end
