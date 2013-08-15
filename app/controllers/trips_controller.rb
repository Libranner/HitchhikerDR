class TripsController < ApplicationController
  load_and_authorize_resource

  # GET /trips
  # GET /trips.json
  def index
   #@trips = Trip.all
    @trips = Trip.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    #@trip = Trip.find(params[:id])
    @status = status
    @frequencies = frequencies

    #@json = @trip.to_gmaps4rails
    #from = @trip.from_coordinates
    #to = @trip.to_coordinates

    @polylines = {direction: { data: { from:"#{@trip.from}", to:"#{@trip.to}" }},
                  "map_options" => {center: "#{@trip.from}", "zoom" => 12, "auto_adjust" => true} }
    #debugger
    #{:direction=>{:data=>{:from=>"Bronx, NY", :to=>"Statue of liberty, NY"}}}
    #@polylines = {direction: { data: {  "from" => "Bronx, New York", "to" => "Queens, new york"} }}

    #@trip.near_destination
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    #@trip = Trip.new
    @status = status
    @frequencies = frequencies

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    @status = status
    @frequencies = frequencies

    #@trip = Trip.find(params[:id])
  end

  # POST /trips
  # POST /trips.json
  def create
    #@trip = Trip.new(params[:trip])
    @status = status
    @frequencies = frequencies


    @trip = current_user.trips.build(params[:trip])

    #destination = Destination.new
    #destination.address = trip.to
    #destination.geocode
    #@trip.address = @trip.to
    #trip.destination = destination
    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { render action: 'new' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    #@trip = Trip.find(params[:id])

    respond_to do |format|
      if @trip.update_attributes(params[:trip])
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end


  def reserve
    @trip = Trip.find(params[:trip_id])

    if @trip.users_checkin.include? current_user
      @trip.destroy_reservation current_user
      redirect_to @trip, notice: 'You canceled a reservation in this trip.'
    else
      @trip.add_reservation(current_user, 1)
      redirect_to @trip, notice: 'You have a reservation in this trip.'
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    #@trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end

  private
    def status
      status = {}
      status[1] = 'Active'
      status[2] = 'In Process'
      status[3] = 'Finished'
      status
    end

    def frequencies
      frequencies = {}
      frequencies[0] = 'One time'
      frequencies[1] = 'Diary'
      frequencies[2] = 'Weekly'
      frequencies[3] = 'Monthly'
      frequencies
    end

end
