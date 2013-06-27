class AlertSerializer < ActiveModel::Serializer
  attributes :id, :description, :details, :status, :assigned_to, :created_on

  def assigned_to
    object.assigned_to.id
  end

  def created_on
    object.created_at
  end
end
