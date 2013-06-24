class AlertSerializer < ActiveModel::Serializer
  attributes :id, :description, :details, :status, :assigned_to

  def assigned_to
    object.assigned_to.id
  end
end
