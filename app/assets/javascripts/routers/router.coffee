class App.Router extends Backbone.Router
  routes:
    "users/:id(/)": "user"
    "(/)": "home"
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
    grid = new App.Views.AlertGrid
      collection: alerts
    alerts.fetch reset:true, success: ->
      $ -> $('.alerts-grid').append(grid.render().$el)

App.router = new App.Router()
Backbone.history.start(pushState:true)
