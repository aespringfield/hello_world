class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    supplier = Supplier.new(supplier_params)
    if supplier.save
      redirect_to supplier
    else
      flash[:errors] = review.errors.full_messages
      render 'new'
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :ein, :address_1, :address_2, :city, :state, :phone_number)
  end
end
