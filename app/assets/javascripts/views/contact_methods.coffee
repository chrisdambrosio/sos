class App.Views.ContactMethod extends Backbone.View
  className: 'contact-method'
  events:
    'click a.edit': 'edit'
    'click a.remove': 'destroy'
  template: JST['templates/contact_method']
  render: ->
    @$el.html(@template(@model.attributes))
    @$el.find('a[rel=tooltip]').tooltip(delay:{show:815})
    this
  edit: (e) ->
    e.preventDefault()
    contactMethodForm = new App.Views.ContactMethodForm(model:@model)
    @$el.html(contactMethodForm.render().el)
  destroy: (e) ->
    return unless confirm("Delete #{@model.get('address')}?")
    e.preventDefault()
    @model.destroy
      success: => @remove()

class App.Views.ContactMethods extends Backbone.View
  initialize: (options) ->
    @collection.on('reset', @render)
  className: 'contact-method-groups'
  template: JST['templates/contact_methods']
  events:
    'click a': 'newContactMethod'
  render: () =>
    @$el.html(@template())
    @addAll()
    $('#contact-method-list').html(@$el)
    this
  addAll: () =>
    @collection.forEach(@addOne)
  addOne: (contactMethod) =>
    contactMethodView = new App.Views.ContactMethod(model: contactMethod)
    @$el.find(".contact-methods-#{contactMethod.get('contact_type')} .contact-methods")
      .append(contactMethodView.render().el)
  newContactMethod: (e) =>
    contactMethod = new App.Models.ContactMethod
      contact_type: $(e.target).data('contact-type')
      user_id: @collection.user.id
    contactMethodForm = new App.Views.ContactMethodForm
      model: contactMethod
    $(".contact-methods-#{contactMethod.get('contact_type')} .contact-methods")
      .append contactMethodForm.render().el

class App.Views.ContactMethodForm extends Backbone.View
  className: 'contact-method'
  template: JST['templates/contact_method_form']
  events:
    'click .cancel': 'cancel'
    'submit': 'save'
  render: =>
    @$el.html(@template(@model.attributes))
    this
  save: (e) ->
    e.preventDefault()
    attrs =
      label: @$el.find('[name=label]').val()
      address: @$el.find('[name=address]').val()
    @model.save attrs,
      success: (model, response, options) =>
        contactMethod = new App.Models.ContactMethod(response.contact_method)
        contactMethodView = new App.Views.ContactMethod(model:contactMethod)
        @$el.html(contactMethodView.render().el)
  cancel: (e) ->
    e.preventDefault()
    if @model.isNew()
      @remove()
    else
      contactMethodView = new App.Views.ContactMethod(model:@model)
      @$el.html(contactMethodView.render().el)
