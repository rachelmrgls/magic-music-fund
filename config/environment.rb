# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

require 'casclient'
require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
	:cas_base_url  => "https://fed.princeton.edu/cas/",
  	:login_url     => "https://fed.princeton.edu/cas/login",
    :logout_url    => "https://fed.princeton.edu/cas/logout",
    :validate_url  => "https://fed.princeton.edu/cas/serviceValidate",
    #:extra_attributes_session_key => :cas_extra_attributes,
   	#:enable_single_sign_out => true,
    #:authenticate_on_every_request => true,
	:service_url => "http://princeton-fanfare.herokuapp.com"
    #:service_url => "http://localhost:3000"
)