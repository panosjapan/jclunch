class Admin::MenusController < AdminController
before_filter :authorize_admin  
  # GET /menus
  # GET /menus.json

  
  def index
    if params[:term].present?
      @menus = Menu.order(:name).where("name like ?", "%#{params[:term]}%")
    else
      @menus = Menu.includes(:category)
    end
    
     respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @menus.map(&:name) }
      end
    end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu = Menu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    @menu = Menu.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.find(params[:id])
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(params[:menu])

    respond_to do |format|
      if @menu.save
        format.html { redirect_to [:admin,@menu], notice: 'Menu was successfully created.' }
        format.json { render json: @menu, status: :created, location: @menu }
      else
        format.html { render action: "new" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @menu = Menu.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to [:admin,@menu], notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to admin_menus_url }
      format.json { head :no_content }
    end
  end
  
  def toggle
    @menu = Menu.find(params[:id])
    if @menu.active?
      @menu.hide!
    else
      @menu.activate!
    end
    redirect_to :back
  end
end
