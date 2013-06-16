class App.Router extends Backbone.Router
  routes:
    "users/:id(/)": "user"
  user: (id) ->
    options = { user : { id: id } }
    window.contactMethods = new App.Collections.ContactMethods([], options)
    window.contactMethodsView = new App.Views.ContactMethods
      collection: contactMethods
    window.contactMethods.fetch(reset:true)
    $ -> $('#contact-method-list a').on 'click', ->
      type = $(this).data('type')
      contactMethod = new App.Models.ContactMethod(type:type)
      contactMethodForm = new App.Views.ContactMethodForm(contactMethod)
      $(".contact-methods-#{contactMethod.get('type')} .contact-methods")
        .append contactMethodForm.render().el

App.router = new App.Router()
Backbone.history.start(pushState:true)
