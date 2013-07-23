App.Views.Schedules ||= {}

class App.Views.Schedules.Schedule extends Backbone.View
  className: 'schedule-summary'
  template: JST['templates/schedules/schedule']
  render: =>
    @$el.html(@template(@model.attributes))
    this
  events:
    'click .schedule-name a': 'navToSchedule'
  navToSchedule: (e) =>
    e.preventDefault()
    url = @$el.find('a').attr('href')
    App.router.navigate(url, trigger:true)
