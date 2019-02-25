class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.find_with_same_director(id)
    movie = Movie.find(id)
    if (movie.director.nil? or movie.director.empty?)
      return [movie, nil]
    end
    same_movies = Movie.where(:director => movie.director)
    [movie, same_movies]
  end
end