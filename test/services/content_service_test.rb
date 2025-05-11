require "test_helper"

class ContentServiceTest < ActiveSupport::TestCase
  test 'get movie by id' do
    data = ContentService.get('movies', 1)
    assert_equal('Star Wars: Episode V - The Empire Strikes Back', data['original_title'])
    assert_equal(1980, data['year'])
    assert_equal(7440, data['duration_in_seconds'])
  end

  test 'get tv show by id' do
    data = ContentService.get('tv_shows', 1)
    assert_equal('Kimetsu No Yaiba: Demon Slayer', data['original_title'])
    assert_equal(2019, data['year'])
    assert_nil(data['duration_in_seconds'])
  end

  test 'get season by id' do
    data = ContentService.get('seasons', 1)
    assert_equal('Tanjiro Kamado, Unwavering Resolve Arc', data['original_title'])
    assert_equal(1, data['number'])
    assert_equal(2019, data['year'])
    assert_nil(data['duration_in_seconds'])
  end

  test 'get episode by id' do
    data = ContentService.get('episodes', 1)
    assert_equal('Cruelty', data['original_title'])
    assert_equal(1, data['number'])
    assert_equal(1, data['season_number'])
    assert_equal(2019, data['year'])
    assert_equal(3600, data['duration_in_seconds'])
  end

  test 'get channel by id' do
    data = ContentService.get('channels', 1)
    assert_equal('Nickelodeon', data['original_title'])
    assert_nil(data['year'])
    assert_nil(data['duration_in_seconds'])
  end

  test 'get channel program by id' do
    data = ContentService.get('channel_programs', 1)
    assert_equal('SpongeBob', data['original_title'])
    assert_nil(data['year'])
    assert_nil(data['duration_in_seconds'])
    assert_nil(data['watched_time'])
  end

  test 'search content by title' do
    data = ContentService.search('star')
    assert_equal('Star Wars: Episode V - The Empire Strikes Back', data[:movies][0].original_title)
    assert_equal(1980, data[:movies][0].year)
    assert_equal(7440, data[:movies][0].duration_in_seconds)
  end

  test 'search content by year' do
    data = ContentService.search(2016)
    assert_equal('Stranger Things', data[:tv_shows][0].original_title)
    assert_equal('Season 1', data[:seasons][0].original_title)
    assert_equal('Chapter One: The Vanishing of Will Byers', data[:episodes][0].original_title)
  end

  test 'search app by name' do
    data = ContentService.search('prime')
    assert_equal('prime_video', data[:apps][0].name)
  end
end
