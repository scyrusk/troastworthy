class TroastsController < ApplicationController
  # GET /troasts
  # GET /troasts.json
  def index
    @troasts = Troast.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @troasts }
    end
  end

  # GET /troasts/1
  # GET /troasts/1.json
  def show
    @troast = Troast.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @troast }
    end
  end

  # GET /troasts/new
  # GET /troasts/new.json
  def new
    @troast = Troast.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @troast }
    end
  end

  # GET /troasts/1/edit
  def edit
    @troast = Troast.find(params[:id])
  end

  # POST /troasts
  # POST /troasts.json
  def create
    @troast = Troast.new(params[:troast])

    respond_to do |format|
      if @troast.save
        format.html { redirect_to @troast, notice: 'Troast was successfully created.' }
        format.json { render json: @troast, status: :created, location: @troast }
      else
        format.html { render action: "new" }
        format.json { render json: @troast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /troasts/1
  # PUT /troasts/1.json
  def update
    @troast = Troast.find(params[:id])

    respond_to do |format|
      if @troast.update_attributes(params[:troast])
        format.html { redirect_to @troast, notice: 'Troast was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @troast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /troasts/1
  # DELETE /troasts/1.json
  def destroy
    @troast = Troast.find(params[:id])
    @troast.destroy

    respond_to do |format|
      format.html { redirect_to troasts_url }
      format.json { head :ok }
    end
  end
end
