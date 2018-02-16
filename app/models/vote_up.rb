class VoteUp < Vote
  belongs_to :voteable, polymorphic: true, counter_cache: true

  default_scope { where(vote: true) }

  def default_values
    return unless self.new_record?
    self.vote = true
  end
end
