class App.Views.ScheduleLayer extends Backbone.View
  initialize: (options) ->
    @schedule = options.schedule
    @startOfWeek = options.startOfWeek
  className: 'timeline-layer'
  template: JST['templates/schedule_layer']
  render: ->
    @$el.html(@template(@model.attributes))
    for entry in @model.get('rendered_schedule_entries')
      window.entryView = new App.Views.ScheduleEntry
        model: new App.Models.ScheduleEntry(entry)
        schedule: @schedule
        startOfWeek: @startOfWeek
      @$el.find('.timeline-layer-grid').append(entryView.render().el)
    this

class App.Views.ScheduleEntry extends Backbone.View
  initialize: (options) ->
    @schedule = options.schedule
    @startOfWeek = options.startOfWeek
  className: 'timeline-bar'
  template: JST['templates/schedule_entry']
  getOffsetPercent: ->
    secondsInTimeline = 86400 * @schedule.days
    offsetSeconds = (moment(@model.get('start_time')) - @startOfWeek) / 1000
    (offsetSeconds / secondsInTimeline) * 100
  getWidthPercent: ->
    secondsInTimeline = 86400 * @schedule.days
    (@model.getDuration() / secondsInTimeline) * 100
  render: ->
    console.log(@getOffsetPercent())
    @$el.html(@template(@model.attributes))
    @$el.css('width', "#{@getWidthPercent()}%")
    @$el.css('margin-left', "#{@getOffsetPercent()}%")
    this
