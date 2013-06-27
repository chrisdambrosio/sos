class App.Models.Alert extends Backbone.Model
  url: ->
    if @id
      "/api/v1/alerts/#{@id}.json"
    else
      "/api/v1/alerts.json"
  defaults:
    details: null
    description: null
  toJSON: ->
    { alert: @attributes }
