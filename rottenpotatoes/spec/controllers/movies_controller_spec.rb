require 'rails_helper'
require 'spec_helper'
require 'rspec/rails'

describe MoviesController do
  describe 'find movies with same director' do
    it 'calls the model method that returns movies with the same director' do
        expect(Movie).to receive(:find_with_same_director).with("1")
        get :search_directors, {:id => 1}
    end
    it 'selects the Search Results template for rendering'
    it 'makes the TMDb search results available to that template'
  end
end