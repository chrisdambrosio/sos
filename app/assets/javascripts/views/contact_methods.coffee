class App.Views.ContactMethod extends Backbone.View
  initialize: (options) ->
    @model = options.model
  template: JST['templates/contact_method']
  render: ->
    @$el.html(@template(@model.attributes))
    this

class App.Views.ContactMethods extends Backbone.View
  initialize: (options) ->
    @collection.on('reset', @render)
  render: () =>
    @addAll()
    this
  addAll: () =>
    @$el.find('.contact_methods').empty()
    @collection.forEach(@addOne)
  addOne: (contactMethod) =>
    contactMethodView = new App.Views.ContactMethod(model: contactMethod)
    $(".contact-methods-#{contactMethod.get('type')} .contact-methods")
      .append(contactMethodView.render().el)

class App.Views.ContactMethodForm extends Backbone.View
  initialize: (contactMethod) ->
    @model = contactMethod or new App.Models.ContactMethod(address:null)
  className: 'contact-method'
  template: JST['templates/contact_method_form']
  events:
    'click .cancel': 'remove'
  render: =>
    @$el.html(@template(@model.attributes))
    this
