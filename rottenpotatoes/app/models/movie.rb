class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.find_with_same_director(id)
    movie = Movie.find(id)
    if not movie.director.nil?
      same_movies = Movie.where(:director => movie.director)
    end
    [movie, same_movies]
  end
end