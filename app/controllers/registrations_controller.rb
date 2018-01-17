class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end
  def after_sign_in_path_for(resource)
    gitrepos_newrepo_path
  end
end
