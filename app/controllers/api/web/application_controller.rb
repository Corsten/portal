class Api::Web::ApplicationController < Api::ApplicationController
  skip_before_action :verify_authenticity_token
end
