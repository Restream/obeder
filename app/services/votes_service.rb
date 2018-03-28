class VotesService
  class << self
    def assign_dish_vote(vote_type, voter)
      voteable = vote_type.voteable
      prev_counters = voteable.slice(:vote_ups_count, :vote_downs_count)

      vote_type.voted ? voteable.voted_by(voter) : voteable.unvoted_by(voter)
      voteable.reload

      update_total_dish_counters(prev_counters, voteable)
    end

    private
    def update_total_dish_counters(prev_counters, voteable)
      actual_counters = voteable.slice(:vote_ups_count, :vote_downs_count)

      total_votes = voteable.dish.slice(:vote_ups_count, :vote_downs_count)
      total_votes[:vote_ups_count] += actual_counters[:vote_ups_count] - prev_counters[:vote_ups_count]
      total_votes[:vote_downs_count] += actual_counters[:vote_downs_count] - prev_counters[:vote_downs_count]

      voteable.dish.update(total_votes)
    end
  end
end
