class DeliveryJob
  include SuckerPunch::Job
  workers 10

  def perform(id)
    notification = Notification.find(id)
    notification.update_attributes(status: 'sending')
    notification.deliver
    notification.update_attributes(status: 'success')
  end
end
