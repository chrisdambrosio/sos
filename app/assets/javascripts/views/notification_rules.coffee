class App.Views.NotificationRule extends Backbone.View
  initialize: (options) ->
    @contactMethods = options.contactMethods
    @contactMethod = @contactMethods.get(@model.get('contact_method_id'))
    @contactMethods.on 'sync', @render
    @contactMethods.on 'remove', @onContactMethodsRemove
  className: 'notification-rule well well-small'
  events:
    'click a.edit': 'edit'
    'click a.remove': 'destroy'
  template: JST['templates/notification_rules/show']
  render: =>
    @$el.html(@template(@model.attributes))
    @$el.find('a[rel=tooltip]').tooltip(delay:{show:815})
    this
  edit: (e) ->
    e.preventDefault()
    notificationRuleForm = new App.Views.NotificationRuleForm
      model: @model
      collection: @collection
      contactMethods: @contactMethods
    this.undelegateEvents()
    notificationRuleForm.setElement(@el)
    notificationRuleForm.render()
  destroy: (e) ->
    e.preventDefault()
    return unless confirm("Delete rule?")
    @model.destroy
      success: => @remove()
  onContactMethodsRemove: (model) =>
    if model.id is @model.get('contact_method_id')
      this.remove()
      @collection.remove(@model)

class App.Views.NotificationRules extends Backbone.View
  initialize: (options) ->
    @contactMethods = options.contactMethods
    @collection.on('reset', @render)
  className: 'notification-rules-container'
  template: JST['templates/notification_rules/index']
  events:
    'click a.add-notification-rule': 'newNotificationRule'
  render: () =>
    @$el.html(@template())
    @addAll()
    $('.notification-rule-list').html(@$el)
    this
  addAll: () =>
    @collection.forEach(@addOne)
  addOne: (notificationRule) =>
    notificationRuleView = new App.Views.NotificationRule
      model: notificationRule
      collection: @collection
      contactMethods: @contactMethods
    @$el.find('.notification-rules').append(notificationRuleView.render().el)
  newNotificationRule: (e) =>
    e.preventDefault()
    notificationRule = new App.Models.NotificationRule
      user: @collection.user
    notificationRuleForm = new App.Views.NotificationRuleForm
      model: notificationRule
      collection: @collection
      contactMethods: @contactMethods
    @$el.find('.notification-rules')
      .append notificationRuleForm.render().el

class App.Views.NotificationRuleForm extends Backbone.View
  initialize: (options) ->
    @contactMethods = options.contactMethods
    @contactMethods.on 'sync', @render
    @contactMethods.on 'remove', @onContactMethodsRemove
  className: 'notification-rule well well-small'
  template: JST['templates/notification_rules/form']
  events:
    'click .cancel': 'cancel'
    'submit': 'save'
  render: =>
    @$el.html(@template(@model.attributes))
      .find('select[name="contact-method-id"]').val(@model.get('contact_method_id'))
    this
  save: (e) ->
    e.preventDefault()
    attrs =
      start_delay: @$el.find('[name=start-delay-in-minutes]').val()
      contact_method_id: @$el.find('[name=contact-method-id]').val()
    @model.save attrs,
      success: (model, response, options) =>
        notificationRule = model.set(response.notification_rule)
        @collection.add(notificationRule)
        notificationRuleView = new App.Views.NotificationRule
          model: notificationRule
          collection: @collection
          contactMethods: @contactMethods
        this.undelegateEvents()
        notificationRuleView.setElement(@el)
        notificationRuleView.render()
  cancel: (e) ->
    e.preventDefault()
    if @model.isNew()
      @remove()
    else
      notificationRuleView = new App.Views.NotificationRule
        model: @model
        contactMethods: @contactMethods
      this.undelegateEvents()
      notificationRuleView.setElement(@el)
      notificationRuleView.render()
  onContactMethodsRemove: (model) =>
    if model.id is @model.get('contact_method_id')
      this.remove()
      @collection.remove(@model)
