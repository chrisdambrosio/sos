class NotificationsJob
  include SuckerPunch::Job
  workers 3

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      notifications = Notification.ready_to_send
      notifications.each do |notification|
        DeliveryJob.new.async.perform(notification.id)
      end
    end
  end
end
