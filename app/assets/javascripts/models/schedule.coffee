class App.Models.Schedule extends Backbone.Model
  #initialize: (options) ->
    #@user = options.user or @collection.user
  url: ->
    if @id
      "/api/v1/schedules/#{@id}.json"
    else
      "/api/v1/schedules.json"
  #defaults:
    #start_delay: 0
    #contact_method_id: null
  toJSON: ->
    { schedule: @attributes }
