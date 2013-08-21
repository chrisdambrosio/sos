class App.Router extends Backbone.Router
  routes:
    "(/)": "home"
    "users/:id(/)": "user"
    "alerts/:alert_id(/)": "alert"
    "schedules(/)": "schedules"
    "schedules/:id": "schedule"
  user: (id) ->
    options = { user : { id: id } }
    contactMethods = new App.Collections.ContactMethods([], options)
    contactMethodsView = new App.Views.ContactMethods
      collection: contactMethods
    $('#contact-method-list').html(contactMethodsView.render().el)
    notificationRules = new App.Collections.NotificationRules([], options)
    notificationRulesView = new App.Views.NotificationRules
      collection: notificationRules
      contactMethods: contactMethods
    $ -> contactMethods.fetch reset: true, success: ->
      notificationRules.fetch(reset:true)
  home: ->
    window.alerts = new App.Collections.Alerts([])
    window.paginationView = new App.Views.Pagination(collection:alerts)
    window.grid = new App.Views.AlertGrid
      collection: alerts
    window.alertActions = new App.Views.AlertActions(grid:grid)
    alerts.fetch
      reset: true
      success: ->
        $ ->
          $('.alerts-grid').append(grid.render().$el)
          $('.pagination-container').append(paginationView.el)
          $('.alert-actions').html(alertActions.render().el)
      data: { limit: 10, offset: 0 }
  alert: (alert_id) ->
    window.logEntries = new App.Collections.LogEntries({}, {alertId: alert_id})
    logEntries.fetch success: ->
      logEntriesView = new App.Views.LogEntries(collection: logEntries)
      $ -> $('#le-table > table').append(logEntriesView.render().el)
  schedules: ->
    window.schedules = new App.Collections.Schedules()
    schedules.fetch
      data: { limit: 10, offset: 0 }
      success: ->
        schedulesView = new App.Views.Schedules.Index
          collection: schedules
        $ -> $('#schedules-page-content').html(schedulesView.render().el)
  schedule: (id) ->
    days = 7
    window.startOfWeek = moment().utc().isoWeekday(1).hour(0).minute(0).second(0).millisecond(0)
    window.endOfTimeline = moment(startOfWeek).add('days', days)
    window.schedule = new App.Models.Schedule(id:id, days:days)
    schedule.fetch
      reset: true
      data: (since:startOfWeek.toISOString(), until:endOfTimeline.toISOString())
      success: ->
        window.scheduleView = new App.Views.Schedules.Show
          model: schedule
          startOfWeek: startOfWeek
        scheduleView.render()
        for layer in schedule.scheduleLayers
          layerView = new App.Views.ScheduleLayer
            model: layer
            schedule: schedule
            startOfWeek: startOfWeek
          scheduleView.$el.find('.team-schedule').append(layerView.render().el)
        finalLayerView = new App.Views.ScheduleLayer
          model: schedule.finalSchedule
          schedule: schedule
          startOfWeek: startOfWeek
        scheduleView.$el.find('.final-schedule').append(finalLayerView.render().el)
        $ ->
          $('#schedules-page-content').html(scheduleView.el)

App.router = new App.Router()
Backbone.history.start(pushState:true)
