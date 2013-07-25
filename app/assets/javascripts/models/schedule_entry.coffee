class App.Models.ScheduleEntry extends Backbone.Model
  getDuration: ->
    ms = moment(@get('end_time')) - moment(@get('start_time'))
    ms / 1000
