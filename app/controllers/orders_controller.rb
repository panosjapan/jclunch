class OrdersController < ApplicationController
  skip_before_filter :authorize_admin
  
  # GET /orders
  # GET /orders.json
  def index
   @orders = Order.where('user_id' => current_user.id).order('date DESC').page(params[:page]).per(15)
   @line_items = LineItem.where('user_id' => current_user.id).order('date DESC').page(params[:page]).per(15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
    1.times do
        line_item = @order.line_items.build
      end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
     d = Time.now+14.hour
    if @order.date <= Date.today || @order.date <= d.to_date
     
      flash[:alert] = "You cannot edit a past or next day's order"
      redirect_to(:back)
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])
    
    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
     d = Time.now+14.hour
    @order = Order.find(params[:id])
    if @order.date <= Date.today || @order.date <= d.to_date
      flash[:alert] = "You cannot delete a past or next day's order"
      redirect_to(:back)
    else
        @order.destroy
        redirect_to(:back)
    end
    
  end
  
end
