class WorkRecordsController < ApplicationController
  before_filter :authorize
  
  def index
  
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @work_records = WorkRecord.where('user_id' => current_user.id).monthly(@date)

  end

  
  def attendance

      @today        = Time.now
      @work_record  = current_user.todays_work_record
    
      if @work_record.blank?
        @work_record  = current_user.work_records.build(
                      :work_on        => @today,
                      :wage           => current_user.wage,
                      :department_id  => current_user.department_id)
      
      elsif @work_record.attended?
        @ls = Time.gm(@today.year,@today.month,@today.day,13,00,0)
        @le = @ls + 45.minutes
        @step = current_user.try(:department).try(:minute_step).to_i
      end      

  end
  
  
  def create
    @user = User.find(current_user.id)
    redirect_to root_path, alert: t('alert.spoof') if spoof?
    begin
      @work_record = @user.work_records.build(params[:work_record])
      @work_record.attend!
      msg = t('user_work_records.create.success')
    rescue
      msg = t('commons.error')
    end
    redirect_to attendance_work_records_path, notice: msg
  end
  
  def update
    @user = User.find(current_user.id)
    redirect_to root_path, alert: t('alert.spoof') if spoof?
    @work_record = WorkRecord.find(params[:id])
    
    if @work_record.update_attributes(params[:work_record])
      begin
        @work_record.leave!
        msg = t('user_work_records.leave.success')
      rescue
        msg = t('commons.error')
      end
    else
      msg = t('commons.error')
    end
    redirect_to attendance_work_records_path, notice: msg
  end
  
  def spoof?
    @user != current_user
  end

end
