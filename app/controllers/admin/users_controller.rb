class Admin::UsersController < AdminController
before_filter :authorize_admin  
  
  def index

    @users = User.order("name").page(params[:page]).per(20)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
	
	def edit
    @user = User.find(params[:id])
  end
	
	def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:admin,@user], notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to [:admin,@user], notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end
  
  def time_cards
    @users = User.active
  end
  
  def time_card
    @user = User.find(params[:id])
  end
  
  def download_time_card
    @user = User.find(params[:id])
    date  = params[:date][:year].to_s + "/" + params[:date][:month].to_s + "/01" if params[:date].present?
    date  = params[:year].to_s + "/" + params[:month].to_s + "/01" if date.blank?
    @date = Date.parse(date)
    @work_records = WorkRecord.approved.b_user(@user.id).monthly(@date)
    @total_hours = 0
    @total_pay = 0
    data = CSV.generate do |csv|
      csv << ["DATE","START TIME","LUNCH","END TIME","TOTAL HOURS","HOURS	RATE x HOURS"]
      @work_records.each do |wr|
        @total_hours += wr.daily_work_time
        @total_pay += wr.daily_work_time * wr.wage
        csv << [wr.work_on,wr.start_at_to_strf,wr.lunch_hours,wr.end_at_to_strf,wr.daily_work_time,(wr.daily_work_time * wr.wage)]
      end
      csv << ["","","","",@total_hours,@total_pay]
    end
    if @work_records.present?
      send_data(data, type: 'text/csv', filename: "Time_Card_#{@user.firstname}_#{@date.to_time.strftime('%Y_%B')}.csv") 
    else
      redirect_to :back
    end
  end
	
end
