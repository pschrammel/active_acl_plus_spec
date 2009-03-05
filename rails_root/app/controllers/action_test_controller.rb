class ActionTestController < ApplicationController
  def index
    render :text => "test"
  end
  def caction
    render :text => current_action.action
  end
end