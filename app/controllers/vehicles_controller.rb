class VehiclesController < ApplicationController
  # GET /vehicles
  # GET /vehicles.json
  def index
    @vehicles = Vehicle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vehicles }
    end
  end

  def makes
    makes = Vehicle.distinct(:make)
    respond_to do |format|
      format.json { render json: makes }
      format.html{render json:makes}
    end
  end

  def models
    models = Vehicle.where(:make => params[:make]).distinct(:model)
    respond_to do |format|
      format.json { render json: models }
      format.html{render json: models}
    end
  end

  def years
    years = Vehicle.where(:make => params[:make], :model => params[:model]).distinct(:year)
    respond_to do |format|
      format.json { render json: years }
      format.html{render json: years}
    end
  end

  # GET /vehicles/new
  # GET /vehicles/new.json
  def new
    @vehicle = Vehicle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vehicle }
    end
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    @vehicle = Vehicle.new(params[:vehicle])

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to ('/') }
        format.json { render json: @vehicle, status: :created, location: @vehicle }
      else
        format.html { render action: "new" }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end
end
