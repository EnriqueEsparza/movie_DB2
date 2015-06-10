require "spec_helper"
require "capybara/rspec"
require "./app"
require "pry"
require "launchy"
DB = PG.connect({:dbname => "movie_database_test"})
include Capybara::DSL

Capybara.app = Sinatra::Application
set(:show_expections, false)

describe('adding a movie to the DB', {:type => feature}) do
  it('allows a user to click a link and enter a movie') do
    visit('/')
    click_link('Add a new movie')
    fill_in('name', {:with => 'Thor'})
    click_button('Add movie')
    expect(page).to have_content('Thor')
  end
end

describe('adding a actor to the DB', {:type => feature}) do
  it('allows a user to click a link and enter a actor') do
    visit('/')
    click_link('Add a new actor')
    fill_in('name', {:with => 'Tom Cruise'})
    click_button('Add actor')
    expect(page).to have_content('Tom Cruise')
  end
end

describe('adding movies to an actor', {:type => feature}) do
  it('allows a user to click a checkbox and select a movie') do
    test_actor = Actor.new({:name => 'Bob', :id => nil})
    test_actor.save()
    test_movie = Movie.new({:name => 'The Blob', :id => nil})
    test_movie.save()
    visit('/')
    click_link('Bob')
    visit('/actors/' + test_actor.id().to_s())
    check(test_movie.name())
    click_button('Add movies')
    expect(page).to have_content('Here are all the movies starring this actor:')
  end
end
# save_and_open_page
