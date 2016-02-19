class AdditionalInformationsController < ApplicationController
  before_action :set_additional_information, only: [:show, :edit, :update, :destroy]

  # GET /additional_informations
  def index
    @additional_informations = AdditionalInformation.all
  end

  # GET /additional_informations/1
  def show
  end

  # GET /additional_informations/new
  def new
    @additional_information = AdditionalInformation.new
  end

  # GET /additional_informations/1/edit
  def edit
  end

  # POST /additional_informations
  def create
    @additional_information = AdditionalInformation.new(additional_information_params)

    if @additional_information.save
      redirect_to @additional_information, notice: 'Additional information was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /additional_informations/1
  def update
    if @additional_information.update(additional_information_params)
      redirect_to @additional_information, notice: 'Additional information was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /additional_informations/1
  def destroy
    @additional_information.destroy
    redirect_to additional_informations_url, notice: 'Additional information was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_additional_information
      @additional_information = AdditionalInformation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def additional_information_params
      params.require(:additional_information).permit(:sex, :birth_date, :birth_place, :civil_status, :nationality, :user_id)
    end
end
