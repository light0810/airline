module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    page_title.empty? ? base_title : page_title
  end

  def bootstrap_class_for flash_type
    case flash_type
      when "success"
        "alert-success" # Green
      when "error"
        "alert-danger" # Red
      when "danger"
        "alert-danger" # Red
      when "alert"
        "alert-warning" # Yellow
      when "notice"
        "alert-info" # Blue
      else
        flash_type.to_s
    end
  end
end
