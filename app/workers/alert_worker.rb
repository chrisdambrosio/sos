class AlertWorker
  include SuckerPunch::Worker

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      #something like..
      alerts = Alert.where(status: 'assigned')
      alerts.each do |alert|
        notifications = alert.notifications.ready_to_send
        notifications.each { |notification| notification.send }
      end
    end
  end
end
