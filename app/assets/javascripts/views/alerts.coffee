class App.Views.AlertGrid extends Backgrid.Grid
  initialize: (options) ->
    super
      collection:options.collection
      columns: @alertColumns()
  alertColumns: ->
    [
      name: ''
      cell: 'select-row'
      headerCell: 'select-all'
    ,
      editable: false
      name: 'id'
      label: 'ID'
      cell: Backgrid.UriCell.extend
        render: ->
          Backgrid.UriCell.prototype.render.call(this)
          @$('a').attr('href', "/alerts/#{@model.id}").removeAttr('target')
          this
    ,
      editable: false
      name: 'created_on'
      label: 'Created On'
      cell: Backgrid.StringCell.extend
        render: ->
          Backgrid.StringCell.prototype.render.call(this)
          dateStr = moment(@model.get('created_on')).format('ddd MMM DD HH:mm')
          @$el.text(dateStr)
          this
    ,
      editable: false
      name: 'description'
      label: 'Description'
      cell: 'string'
    ,
      editable: false
      name: 'assigned_to'
      label: 'Assigned To'
      cell: 'string'
    ,
      editable: false
      name: 'status'
      label: 'Status'
      cell: 'string'
    ]

class App.Views.AlertActions extends Backbone.View
  initialize: (options) ->
    @grid = options.grid
  template: JST['templates/alert_actions']
  render: ->
    @$el.html(@template())
    this
  events:
    'click a.new-alert': ->
      alertForm = new App.Views.AlertForm(collection:@grid.collection)
    'change .page-size': -> console.log 'foo!'

class App.Views.AlertForm extends Backbone.View
  initialize: ->
    @setElement('#new-alert-dialog')
    @$el.modal('show')
    @resetForm()
  resetForm: ->
    @initRecipients()
    @$('input[name=description]').val('')
    @$('textarea[name=details]').val('')
  initRecipients: ->
    @$('.chzn-select').empty()
    @$('.chzn-select').append('<option />').chosen()
    $.getJSON '/api/v1/users.json', (data) =>
      for user in data.users
        @$('.chzn-select')
          .append("<option value=\"#{user.id}\">#{user.name}</option>")
          .trigger("liszt:updated")
  events:
    'click .submit': ->
      assignedTo = @$('.chzn-select').val()
      description = @$('input[name=description]').val()
      details = @$('textarea[name=details]').val()
      alert = new App.Models.Alert
        assigned_to: assignedTo
        description: description
        details: details
      alert.save {},
        success: =>
          @collection.fetch
            data:
              limit: @collection.limit
              offset: 0
          @$el.modal('hide')
          @undelegateEvents()
        error: ->
          console.error 'there was an error'
