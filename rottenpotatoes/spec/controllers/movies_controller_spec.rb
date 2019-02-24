require 'rails_helper'
require 'spec_helper'
require 'rspec/rails'

describe MoviesController do
  describe 'find movies with same director' do
    it 'calls the model method that returns movies with the same director' do
      expect(Movie).to receive(:find_with_same_director).with("1")
      get :search_directors, {:id => 1}
    end
    it 'selects the Search Results template for rendering' do
      Movie.stub(:find_with_same_director)
      get :search_directors, {:id => 1}
      expect(response).to render_template('search_directors')
    end
    it 'makes the movies with same director search results available to that template' do
      fake_movie = double('Movie')
      fake_same_movies = [double('Movie1'), double('Movie2')]
      #Movie.stub(:find_with_same_director).and_return([fake_movie, fake_same_movies])
      allow(Movie).to receive(:find_with_same_director){ [fake_movie, fake_same_movies] }
      get :search_directors, {:id => 1}
      expect(assigns(:same_movies)).to eq(fake_same_movies)
      expect(assigns(:movie)).to eq fake_movie
    end
  end
end