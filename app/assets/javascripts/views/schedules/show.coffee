App.Views.Schedules ||= {}

class App.Views.Schedules.Show extends Backbone.View
  initialize: (options={}) ->
    @days = @model.days
    @startOfWeek = options.startOfWeek
  template: JST['templates/schedules/show']
  render: =>
    @$el.html(@template(@model.attributes))
    this
