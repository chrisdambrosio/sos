class App.Collections.NotificationRules extends Backbone.Collection
  model: App.Models.NotificationRule
  initialize: (models, options) ->
    @user = options.user
    @url = "/api/v1/users/#{@user.id}/notification_rules.json"
  parse: (response) ->
    response.notification_rules
  comparator: 'start_delay'
