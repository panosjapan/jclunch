class WelcomeController < ApplicationController
  skip_before_filter :authorize_admin
  
  def index
  end

  def privacy_policy
  end

  def terms_and_conditions
  end
end
