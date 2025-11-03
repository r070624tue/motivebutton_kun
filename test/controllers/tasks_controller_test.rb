require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test 'should get show with valid date' do
    get task_show_path(date: '2025-08-20')
    assert_response :success
  end

  test 'should redirect to root with invalid date' do
    get task_show_path(date: 'invalid-date')
    assert_redirected_to root_path
  end

  test 'should redirect to login if not logged in when accessing show' do
    sign_out @user # ログイン状態を解除
    get task_show_path(date: '2025-08-20')
    assert_redirected_to new_user_session_path
  end

  test 'should redirect to login if not logged in when accessing edit' do
    sign_out @user # ログイン状態を解除
    get edit_task_by_date_path(date: '2025-08-20')
    assert_redirected_to new_user_session_path
  end

  test 'should redirect to new mood path if no mood selected for edit' do
    # ユーザーのその日の気分を削除して、気分が選択されていない状態を再現
    @user.moods.where(date_on: '2025-08-20').destroy_all
    get edit_task_by_date_path(date: '2025-08-20')
    assert_redirected_to new_mood_path
  end

  test 'should get index' do
    get tasks_url
    assert_response :success
  end
end