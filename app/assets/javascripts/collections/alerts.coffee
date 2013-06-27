class App.Collections.Alerts extends Backbone.Collection
  model: App.Models.Alert
  initialize: (models, options) ->
    @url = "/api/v1/alerts.json"
  parse: (response) ->
    response.alerts
