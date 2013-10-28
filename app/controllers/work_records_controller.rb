class WorkRecordsController < ApplicationController
  before_filter :authorize
  
  def index
  
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @work_records = WorkRecord.where('user_id' => current_user.id).order('work_on DESC').page(params[:page]).per(15)

  end
  
  def new
    @work_record = WorkRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
  
  def create
    @work_record = WorkRecord.new(params[:work_record])

    respond_to do |format|
      if @work_record.save
        format.html { redirect_to @work_record, notice: 'Work Record was successfully created.' }
        format.json { render json: @work_record, status: :created, location: @work_record }
      else
        format.html { render action: "new" }
        format.json { render json: @work_record.errors, status: :unprocessable_entity }
      end
    end
  end

end
