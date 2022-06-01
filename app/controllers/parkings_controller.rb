class ParkingsController < ApplicationController
  before_action :set_plate, only: %i( out paid)

  def history
    @plate = Plate.where(serial: params[:plate])
    if @plate
      render :json => @plate
    else
      render :show, message: 'plate not found'
    end
  end

  def out
    save_plate! if can_exit?
  end

  def paid
    @plate.paid = true
    save_plate!
  end

  def create
    @plate = Plate.new(plate_params)
    save_plate! 
  end

  private

  def plate_params
    params.require(:parking).permit(:serial)
  end

  def save_plate!
    if @plate.save!
      render json: @plate , message: 'plate was successfully saved', status: :created
    else
      render :json => { :error => 'An error occurred while saving' }, :status => 403
    end
  end

  def set_plate
    @plate = Plate.find(params[:id])
  end

  def can_exit?
    if @plate.paid?
      @plate.left = true
    else
      render :json => { :error => 'Unauthorized' }, :status => 401
      return 
    end
  end
end
