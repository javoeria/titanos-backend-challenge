require "test_helper"

class UsersContentsControllerTest < ActionController::TestCase
  def setup
    @controller = Api::V1::UsersController.new
  end

  test 'returns favorite channel programs of user' do
    get(:favorite_programs, params: { id: 1 })
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_instance_of(String, data[0]['original_title'])
    assert_instance_of(Integer, data[0]['watched_time'])
    assert_equal(true, data[0]['watched_time'] >= data[1]['watched_time'])
  end

  test 'returns favorite apps of user' do
    get(:favorite_apps, params: { id: 1 })
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_instance_of(String, data[0]['name'])
    assert_instance_of(Integer, data[0]['position'])
    assert_equal(true, data[0]['position'] <= data[1]['position'])
  end

  test 'returns error if favorite already created' do
    post(:create_favorite_app, params: { id: 1, app_id: 1, position: 1 })
    assert_response 400
  end
end
