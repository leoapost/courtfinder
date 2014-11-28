class Admin::AddressesController < Admin::ApplicationController
  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @addresses }
    end
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
    @address = Address.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @address }
    end
  end

  # GET /addresses/new
  # GET /addresses/new.json
  def new
    @address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @address }
    end
  end

  # GET /addresses/1/edit
  def edit
    @address = Address.find(params[:id])
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(params[:address])

    respond_to do |format|
      if @address.save
        purge_all_pages
        format.html { redirect_to admin_address_path(@address), notice: 'Address was successfully created.' }
        format.json { render json: @address, status: :created, location: admin_address_url(@address) }
      else
        format.html { 
          flash.now[:error] = 'Could not create the Address'
          render action: "new" 
        }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.json
  def update
    @address = Address.find(params[:id])

    respond_to do |format|
      if @address.update_attributes(params[:address])
        purge_all_pages
        format.html { redirect_to admin_address_path(@address), notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { 
          flash[:error] = 'Address could not be updated'
          render action: "edit" 
        }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    purge_all_pages

    respond_to do |format|
      format.html { redirect_to admin_addresses_url }
      format.json { head :no_content }
    end
  end
end
