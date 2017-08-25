require "sinatra"
require "pg"
require "pry"

set :bind, '0.0.0.0'  # bind to all interfaces

configure :development do
  set :db_config, { dbname: "movie3" }
end

configure :test do
  set :db_config, { dbname: "movies_test" }
end

def db_connection
  begin
    connection = PG.connect(Sinatra::Application.db_config)
    yield(connection)
  ensure
    connection.close
  end
end

get '/actors' do
  actors = db_connection do |conn|
    conn.exec("SELECT DISTINCT * FROM actors ORDER BY name")
  end
  @actors_array = actors.to_a
  erb :'actors/index'
end

get '/actors/:id' do
  db_connection do |conn|
    query = "SELECT * FROM cast_members
    JOIN movies ON movie_id = movies.id
    JOIN actors ON actor_id = actors.id
    WHERE actors.id = '#{params[:id]}';"
    @characters = conn.exec(query).to_a
  end
  erb :'actors/show'
end

get '/movies' do
  db_connection do |conn|
    query = "SELECT movies.id AS id, movies.title AS movie, genres.name AS genre,
    studios.name AS studio, movies.year AS year, movies.rating AS rating FROM movies
    JOIN genres ON genre_id = genres.id
    JOIN studios ON studio_id = studios.id
    ORDER BY movies.title;"
    @movies_array = conn.exec(query).to_a
  end
  erb :'movies/index'
end

get '/movies/:id' do
  db_connection do |conn|
    query= "SELECT movies.title AS movie, genres.name AS genre, actors.id AS actor_id,
    studios.name AS studio, movies.year AS year, movies.rating AS rating, actors.name AS actor FROM cast_members
    JOIN movies ON movie_id = movies.id
    JOIN actors ON actor_id = actors.id
    JOIN genres ON genre_id = genres.id
    JOIN studios ON studio_id = studios.id
    WHERE movies.id = '#{params[:id]}';"
    @movie_info = conn.exec(query).to_a
  end
  erb :'movies/show'
end
