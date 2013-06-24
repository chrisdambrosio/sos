class AlertWorker
  include SuckerPunch::Worker

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      alerts = Alert.assigned
      puts "AlertWorker: found #{alerts.count} assigned alerts"
      alerts.assigned.each do |alert|
        notifications = alert.notifications.ready_to_send
        puts "AlertWorker: found #{notifications.count} ready to send for Alert ##{alert.id}"
        notifications.each do |notification|
          notification.update_attributes(status: 'sending')
          notification.deliver
          notification.update_attributes(status: 'success')
        end
      end
    end
  end
end
