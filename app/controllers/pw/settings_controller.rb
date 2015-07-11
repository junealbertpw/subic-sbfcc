class Pw::SettingsController < ApplicationController
  
  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization
  
  def profile
  end

  def account
  end

  def users
  end

end
