module VoteableConcern
  extend ActiveSupport::Concern
  included do |base|
    has_many :votes, -> { where voteable_type: base }, foreign_key: :voteable_id
    has_many :vote_ups, -> { where voteable_type: base }, foreign_key: :voteable_id
    has_many :vote_downs, -> { where voteable_type: base }, foreign_key: :voteable_id
  end

  def voted_by(user)
    change_vote(VoteUp, VoteDown, user)
  end

  def unvoted_by(user)
    change_vote(VoteDown, VoteUp, user)
  end

  def rating
    vote_ups_count - vote_downs_count
  end

  def change_vote(be_created_vote, be_destroyed_vote, user)
    totals = { ups: vote_ups_count, downs: vote_downs_count }

    be_destroyed_vote.destroy_all(voteable: self, user: user)
    be_created_vote.find_or_create_by!(voteable: self, user: user)
    reload

    { ups: vote_ups_count - totals[:ups], downs: vote_downs_count - totals[:downs] }
  end
end
