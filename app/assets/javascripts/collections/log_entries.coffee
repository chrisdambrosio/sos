class App.Collections.LogEntries extends Backbone.Collection
  model: App.Models.LogEntry
  initialize: (models, options) ->
    #@user = options.user
    @url = "/api/v1/alerts/#{options.alertId}/log_entries.json"
  parse: (response) ->
    response.log_entries
