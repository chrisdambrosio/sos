class LogEntrySerializer < ActiveModel::Serializer
  attributes :id, :created_at, :action, :channel
  has_one :agent, polymorphic: true
  has_one :notification
  has_one :user

  def include_associations!
    include! :agent unless object.action == 'notify'
    include! :notification if object.action == 'notify'
    include! :user if ['assign','notify'].include?(object.action)
  end

  def attributes
    hash = super
    hash.delete(:channel) if object.action == 'notify'
    hash
  end
end
