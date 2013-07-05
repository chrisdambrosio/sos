class LogEntrySerializer < ActiveModel::Serializer
  attributes :id, :created_at, :action, :agent

  def agent
    if object.action.trigger?
      'foo!'
    end
  end
end
