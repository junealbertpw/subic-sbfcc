class Pw::EventsController < ApplicationController

  layout "pw"

  include GlobalHelper
  
  before_action :check_authorization
  
  def index
    
  end

end
