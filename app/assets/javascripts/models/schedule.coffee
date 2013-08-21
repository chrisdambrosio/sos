class App.Models.Schedule extends Backbone.Model
  initialize: (options={}) ->
    @on 'change:schedule_layers', @setScheduleLayers
    @on 'change:schedule_layers', @setFinalSchedule
    @days = options.days
  url: ->
    if @id
      "/api/v1/schedules/#{@id}.json"
    else
      "/api/v1/schedules.json"
  parse: (response) ->
    if response.schedule
      response.schedule
    else
      response
  toJSON: ->
    { schedule: @attributes }
  setScheduleLayers: ->
    @scheduleLayers =
      new App.Models.ScheduleLayer(layer) for layer in @.get('schedule_layers')
  setFinalSchedule: ->
    if layer = @.get('final_schedule')
      @finalSchedule = new App.Models.ScheduleLayer(layer)
