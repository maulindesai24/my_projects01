class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    if resource && resource.deleted_at.nil?
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      respond_with resource, location: admin_user_path(resource)
    else
      flash.now[:alert] = "Invalid email or password"
      self.resource = resource_class.new(sign_in_params)
      render :new
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
