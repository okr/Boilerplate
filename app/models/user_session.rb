# app/models/user_session.rb
class UserSession < Authlogic::Session::Base
	# various configuration goes here, see AuthLogic::Session::Config for more details
	logout_on_timeout true
end