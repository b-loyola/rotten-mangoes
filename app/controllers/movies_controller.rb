class MoviesController < ApplicationController

  def index
    if params[:movie]
      runtime = params[:movie][:runtime_in_minutes].split("-")
      min = runtime[0]
      max = runtime[1] || Movie.maximum("runtime_in_minutes")
      query = params[:movie][:query]
      @movies = Movie.search_title_or_director(query).runtime_between(min,max).order(release_date: :desc).paginate(page: params[:page], per_page: 12)
    else
      @movies = Movie.order(release_date: :desc).paginate(page: params[:page], per_page: 12)
    end
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
  		redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
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
  		params.require(:movie).permit(:title, :release_date, :director, :runtime_in_minutes, :poster, :remote_poster_url, :description)
  	end

end
