require 'test_helper'

class Api::UserMenuVotesControllerTest < ActionController::TestCase
  setup do
    @user_menu = create :user_menu_with_user_menu_dishes
    @dish = @user_menu.dishes.first
    @menu_dish = create :menu_dish, menu_id: @user_menu.menu_id, dish_id: @dish.id

    sign_in @user_menu.user
  end

  test 'update vote up for dish' do
    assert_difference 'VoteUp.count' do
      put :update, params: { user_menu_id: @user_menu.id, user_menu_vote: { dish_id: @dish.id, voted: true } }
      assert_response :success
    end
    @dish.reload
    assert { @dish.vote_ups_count == 1 }
    assert { @dish.vote_downs_count.zero? }
  end

  test 'update vote down for dish' do
    assert_difference 'VoteDown.count' do
      put :update, params: { user_menu_id: @user_menu.id, user_menu_vote: { dish_id: @dish.id, voted: false } }
      assert_response :success
    end
    @dish.reload
    assert { @dish.vote_ups_count.zero? }
    assert { @dish.vote_downs_count == 1 }
  end
end
