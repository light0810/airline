class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def upload user
    dirname = Rails.root.join('public', 'uploads', "user_#{user.id}", 'image')
    FileUtils.mkdir_p(dirname)
    uploaded_io = params[:user][:image]
    unless uploaded_io.nil?
      image_path = dirname.to_s + '/' + uploaded_io.original_filename
      File.open(image_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
      user.image = "/uploads/user_#{user.id}/image/#{uploaded_io.original_filename}"
      user.save
    end
  end

  protected
  def require_admin
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = t("require_admin")
      redirect_to root_url
    end
  end

  private
  def after_sign_in_path_for user
    if user.admin?
      admin_root_path
    else
      root_path
    end
  end
end
