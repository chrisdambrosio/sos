class App.Router extends Backbone.Router
  routes:
    "(/)": "home"
    "users/:id(/)": "user"
    "alerts/:alert_id(/)": "alert"
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

App.router = new App.Router()
Backbone.history.start(pushState:true)
