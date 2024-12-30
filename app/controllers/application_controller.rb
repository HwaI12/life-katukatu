# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :initialize_session
  
  private
  
  def initialize_session
    session[:expenses] ||= []
    session[:accounts] ||= []
  end
end