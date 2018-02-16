class Vote < ActiveRecord::Base
  belongs_to :user

  after_initialize :default_values
  validates_uniqueness_of :voteable_id, scope: %w[voteable_type user_id]

  def default_values; end
end
