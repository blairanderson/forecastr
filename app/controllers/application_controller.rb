class ApplicationController < ActionController::API
  include Authentication
  include TokenAuthentication

  def test_key
    "6c9ded4afdeda42017d4e12eaff59fd77b6219e982d2d8a4dbf6f901d445b3ef"
  end
  
end
