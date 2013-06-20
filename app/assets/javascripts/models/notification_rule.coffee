class App.Models.NotificationRule extends Backbone.Model
  initialize: (options) ->
    @user = options.user or @collection.user
  url: ->
    if @id
      "/api/v1/users/#{@user.id}/notification_rules/#{@id}.json"
    else
      "/api/v1/users/#{@user.id}/notification_rules.json"
  defaults:
    start_delay: 0
    contact_method_id: null
  toJSON: ->
    { notification_rule: @attributes }
