class ReviewsController < ApplicationController
  before_filter :require_login
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user
    @review.save
    redirect_to @product, notice: 'Thank you for your review!'

  end

  def destroy
    @review =  Review.find(params[:id])
    if(current_user.id == @review.user_id)
      @review.destroy
      redirect_to Product.find(@review.product_id)
    else
      flash[:error] = "You cannot delete other users' reviews"
    end
  end

  private
    def review_params
      params.require(:review).permit(:rating, :description)
    end

    def require_login
      unless current_user
        flash[:error] = "You must be logged in to access this section"
      end
    end
end
