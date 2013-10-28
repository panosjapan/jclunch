module WorkRecordsHelper
    
  def time_strftime(t)
    begin
      t.to_time.strftime("%H:%M")
    rescue
      "-"
    end
  end
    
	def show_wr_status(obj)
		case obj.state
		when 'not_attend'
			content_tag :span, obj.human_state_name.capitalize, class: 'label label-inverse'
		when 'attended'
			content_tag :span, obj.human_state_name.capitalize, class: 'label label-info'
		when 'left'
			content_tag :span, obj.human_state_name.capitalize, class: 'label'
		when 'approved'
			content_tag :span, obj.human_state_name.capitalize, class: 'label label-success'
		when 'pending'
			content_tag :span, obj.human_state_name.capitalize, class: 'label label-warning'
		else
			content_tag :span, "ERROR", class: 'label label-important'
		end
	end

	def show_lunch_min(wr)
		begin
			min = wr.lunch_end_at - wr.lunch_start_at
			min.divmod(60)[0].to_s + "mins"
		rescue
			"-"
		end
	end

end
