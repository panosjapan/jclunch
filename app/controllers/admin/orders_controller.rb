class Admin::OrdersController < AdminController
  #skip_before_filter :authorize
  
  # GET /orders
  # GET /orders.json
  def index
    @search = Order.search(params[:q])
      @orders = @search.result
      
      respond_to do |format|
          format.html
          format.pdf do
            pdf = OrderPdf.new(@search.date_cont, view_context)
                 send_data pdf.render, filename: "orders.pdf",
                                       type: "application/pdf",
                                       disposition: "inline"
        end
      end
  end
  

  # GET /orders/1
  # GET /orders/1.json
  def show
     @search = Order.search(params[:q])
       @orders = @search.result
       
        respond_to do |format|
            format.html
            format.pdf do
              pdf = OrderPdf.new(@orders, view_context)
                   send_data pdf.render, filename: "orders.pdf",
                                         type: "application/pdf",
                                         disposition: "inline"
          end
        end
    end
       
  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to [:admin,@order], notice: 'Order was successfully created.' }
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
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to admin_orders_url }
      format.json { head :no_content }
    end
  end
end
