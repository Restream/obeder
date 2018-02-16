class VoteDown < Vote
  belongs_to :voteable, polymorphic: true, counter_cache: true

  default_scope { where(vote: false) }

  def default_values
    return unless self.new_record?
    self.vote = false
  end
end
