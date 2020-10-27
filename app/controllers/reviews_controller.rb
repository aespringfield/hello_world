class ReviewsController < ApplicationController
  before_action :find_supplier, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    review = @supplier.reviews.build(review_params)
    if review.save
      redirect_to review
    else
      flash[:errors] = review.errors.full_messages
      render 'new'
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def find_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  def review_params
    params.require(:review).permit(:title, :body, :rating)
  end
end