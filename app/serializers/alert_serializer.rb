class AlertSerializer < ActiveModel::Serializer
  attributes :id, :description, :details, :status, :created_on
  has_one :assigned_to

  def status
    object.status_name
  end

  def created_on
    object.created_at
  end
end
