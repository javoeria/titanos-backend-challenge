require "test_helper"

class ContentsControllerTest < ActionController::TestCase
  def setup
    @controller = Api::V1::ContentsController.new
  end

  test 'should have required params' do
    assert_raises(Apipie::ParamMissing) do
      get(:index, params: {})
    end
  end

  test 'should have valid params' do
    assert_raises(Apipie::ParamInvalid) do
      get(:index, params: { country: 'gb', type: 'abc' })
    end
  end

  test 'returns content available in a country' do
    get(:index, params: { country: 'gb', type: 'movies' })
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_instance_of(String, data[0]['original_title'])
    assert_instance_of(Integer, data[0]['year'])
    assert_instance_of(Integer, data[0]['duration_in_seconds'])
  end

  test 'returns specific content data' do
    get(:show, params: { type: 'movies', id: 1 })
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_instance_of(String, data['original_title'])
    assert_instance_of(Integer, data['year'])
    assert_instance_of(Integer, data['duration_in_seconds'])
  end

  test 'returns error if content not found' do
    get(:show, params: { type: 'movies', id: 10 })
    assert_response 404
  end

  test 'returns content based on the query' do
    get(:search, params: { q: 'star' })
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_instance_of(String, data['movies'][0]['original_title'])
    assert_instance_of(Integer, data['movies'][0]['year'])
    assert_instance_of(Integer, data['movies'][0]['duration_in_seconds'])
  end
end
