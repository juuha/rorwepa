class RatingsController < ApplicationController
  def index
    return if request.format.html? && fragment_exist?('ratinglist')

    @top_beers = Beer.top 3
    @top_breweries = Brewery.top 3
    @top_users = User.top 3
    @recent_ratings = Rating.recent
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    expire_fragment('ratinglist')
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if current_user.nil?
      redirect_to signin_path, notice: 'You should be signed in.'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    expire_fragment('ratinglist')
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
