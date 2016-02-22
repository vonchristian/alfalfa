class WorkersController < ApplicationController
  def index
    @workers = Worker.all
  end
  def new
    @worker = Worker.new
  end

  def create
    @worker = Worker.create(worker_params)
    if @worker.save
      redirect_to @worker, notice: "Worker successfully saved."
    else
      render :new
    end
  end

  def show
    @worker = Worker.find(params[:id])
  end

  def edit
    @worker = Worker.find(params[:id])
  end

  def update
    @worker = Worker.find(params[:id])
    if @worker.update(worker_params)
      redirect_to @worker, notice: "Worker details updated successfully."
    else
      render :edit
    end
  end

  private
  def worker_params
    params.require(:worker).permit(:first_name, :middle_name, :last_name, :photo, :address, :mobile_number, :position, :email, :sex, :birth_date )
  end
end
