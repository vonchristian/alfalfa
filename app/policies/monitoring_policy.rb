class MonitoringPolicy < Struct.new(:user, :monitoring)
  attr_reader :user, :monitoring

  def initialize(user, post)
    @user = user
    @monitoring = monitoring
  end

  def show?
      user.project_engineer? || user.monitoring_officer? || user.liason_officer? || user.project_manager?
    end
end
