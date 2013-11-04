class Admin::WorkRecordsController < AdminController
  before_filter :authorize_admin  
  
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @work_records = WorkRecord.b_dept(current_user.department_id).daily(@date)
  end

  def new
    @work_record = WorkRecord.new
  end

  def create
    @work_record = WorkRecord.new(params[:work_record])
    
    respond_to do |format|
      if @work_record.save
        format.html { redirect_to @work_record }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end    
  end

  def edit
    @work_record = WorkRecord.find(params[:id])
  end

  def update
    @work_record = WorkRecord.find(params[:id])

    respond_to do |format|
      if @work_record.update_attributes(params[:work_record])
        format.html { redirect_to work_records_path }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  def destroy
    @work_record = WorkRecord.find(params[:id])
    @work_record.destroy

    #redirect_to root_path
  end
  
  def approve
    @work_record = WorkRecord.find(params[:id])
    @work_record.approved_by = current_user.id
    @work_record.approve!
  end
  
  def suspend
    @work_record = WorkRecord.find(params[:id])
    @work_record.approved_by = nil
    @work_record.suspend!
  end
  
  def monthly
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @users = User.b_dept(current_user.department_id).where("users.kind = ?", "Part-Time Staff") 
  end
end
