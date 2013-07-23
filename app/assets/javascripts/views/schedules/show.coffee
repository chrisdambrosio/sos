App.Views.Schedules ||= {}

class App.Views.Schedules.Show extends Backbone.View
  template: JST['templates/schedules/show']
  render: =>
    @$el.html(@template(@model.attributes))
    this
