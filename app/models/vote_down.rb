class VoteDown < Vote
  belongs_to :voteable, polymorphic: true, counter_cache: true

  default_scope { where(vote: false) }

  def default_values
    self.vote = false
  end
end
