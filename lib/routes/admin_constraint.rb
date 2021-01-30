class Routes::AdminConstraint
  include Concerns::Auth

  attr_reader :request
  delegate :session, to: :request

  def self.matches?(request)
    contraint = new(request)
    contraint.matches?
  end

  def initialize(request)
    @request = request
  end

  def matches?
    current_administrator.role.admin?
  end
end
