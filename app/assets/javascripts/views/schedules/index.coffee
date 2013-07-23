App.Views.Schedules ||= {}

class App.Views.Schedules.Index extends Backbone.View
  #initialize: (options) ->
  #className: 'index-schedule-page'
  #events:
    #'click a.edit': 'edit'
    #'click a.remove': 'destroy'
  #template: JST['templates/schedules/index']
  render: =>
    @$el.empty()
    @addAll()
    this
  addOne: (model) =>
    view = new App.Views.Schedules.Schedule(model:model)
    @$el.append(view.render().el)
  addAll: =>
    @collection.each(@addOne)
  #edit: (e) ->
    #e.preventDefault()
    #notificationRuleForm = new App.Views.NotificationRuleForm
      #model: @model
      #collection: @collection
      #contactMethods: @contactMethods
    #this.undelegateEvents()
    #notificationRuleForm.setElement(@el)
    #notificationRuleForm.render()
  #destroy: (e) ->
    #e.preventDefault()
    #return unless confirm("Delete rule?")
    #@model.destroy
      #success: => @remove()
  #onContactMethodsRemove: (model) =>
    #if model.id is @model.get('contact_method_id')
      #this.remove()
      #@collection.remove(@model)
  #iconName: ->
    #switch @contactMethod.get('contact_type')
      #when 'email' then 'icon-envelope-alt'
      #when 'sms' then 'icon-mobile-phone'
      #when 'phone' then 'icon-phone'
