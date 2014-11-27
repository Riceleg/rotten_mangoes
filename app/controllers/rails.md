rails g controller movies index show new edit
------------------------------------------------------------
RottenMangoes::Application.routes.draw do
  resources :movies
end
------------------------------------------------------------

class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
    )
  end

end
----------------------------------------------------------------------------------------------------
Let's take a look at the views. movies/index.html.erb first:

<h1>Rotten Mangoes</h1>
<%= link_to "Submit a movie!", new_movie_path %>
<hr>
<% @movies.each do |movie| %>
  <%= link_to image_tag(movie.poster_image_url), movie_path(movie) %>
  <h2><%= link_to movie.title, movie_path(movie) %></h2>
  <h3><%= movie.release_date %></h3>
  <h4>Dir. <%= movie.director %> | <%= movie.runtime_in_minutes %> minutes</h4>
  <p><%= movie.description %></p>
  <hr>
<% end %>
Nothing too different from our forum app so far. movies/show.html.erb too:

<%= link_to "Back to all movies", movies_path %><br/>

<%= link_to image_tag(@movie.poster_image_url), movie_path(@movie) %>
<h2><%= @movie.title %> (<%= link_to "edit", edit_movie_path(@movie) %>, <%= link_to "delete", movie_path(@movie), method: :delete, confirm: "You sure?" %>)</h2>
<h3><%= @movie.release_date %></h3>
<h4>Dir. <%= @movie.director %> | <%= @movie.runtime_in_minutes %> minutes</h4>
<p><%= @movie.description %></p>