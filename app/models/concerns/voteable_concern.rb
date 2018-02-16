module VoteableConcern
  extend ActiveSupport::Concern
  included do |base|
    has_many :vote_ups, -> { where(voteable_type: base) }, foreign_key: :voteable_id
    has_many :vote_downs, -> { where(voteable_type: base) }, foreign_key: :voteable_id
  end

  def voted_by(user)
    VoteDown.destroy_all(voteable: self, user: user)
    VoteUp.create!(voteable: self, user: user)
    reload
  end

  def unvoted_by(user)
    VoteUp.destroy_all(voteable: self, user: user)
    VoteDown.create!(voteable: self, user: user)
    reload
  end

  def rating
    vote_ups_count - vote_downs_count
  end
end
