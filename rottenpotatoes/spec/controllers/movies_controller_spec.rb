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
      fake_movie = double('Movie')
      fake_same_movies = [double('Movie1'), double('Movie2')]
      allow(Movie).to receive(:find_with_same_director){ [fake_movie, fake_same_movies] }
      get :search_directors, {:id => 1}
      expect(response).to render_template('search_directors')
    end
    it 'makes the movies available to that template' do
      fake_movie = double('Movie')
      fake_same_movies = [double('Movie1'), double('Movie2')]
      #Movie.stub(:find_with_same_director).and_return([fake_movie, fake_same_movies])
      allow(Movie).to receive(:find_with_same_director){ [fake_movie, fake_same_movies] }
      get :search_directors, {:id => 1}
      expect(assigns(:same_movies)).to eq(fake_same_movies)
      expect(assigns(:movie)).to eq fake_movie
    end
    it 'should redirect to home page when movie has no director' do
      fake_movie = double('Movie', :title => "Big Hero 6")
      allow(Movie).to receive(:find_with_same_director){ [fake_movie, nil] }
      get :search_directors, {:id => 1}
      expect(response).to redirect_to movies_path
    end
    it 'should give user a warning when movie has no director' do
      fake_movie = double('Movie', :title => "Big Hero 6")
      allow(Movie).to receive(:find_with_same_director){ [fake_movie, nil] }
      get :search_directors, {:id => 1}
      expect(flash[:notice]).to eq ("'#{fake_movie.title}' has no director info")
    end
  end
end