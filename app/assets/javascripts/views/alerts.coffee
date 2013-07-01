class CustomSortHeaderCell extends Backgrid.HeaderCell
  initialize: ->
    @collection.on 'sync', => @refresh()
    super
  className: 'sortable'
  events:
    'click': 'sort'
  refresh: ->
    @$('.sort-caret').empty()
    @$el.removeClass('asc').removeClass('desc')
    columnName = @column.get('name')
    if columnName is @collection.sort_by
      orderIcon = switch @collection.order
        when 'asc' then 'icon-caret-up'
        when 'desc' then 'icon-caret-down'
      html = "<i class=\"#{orderIcon}\"></i>"
      @$el.addClass(@collection.order)
      @$('.sort-caret').html(html)
  sort: ->
    @collection.order = switch @collection.order
      when undefined then 'asc'
      when 'asc' then 'desc'
    @collection.sort_by = this.column.get('name')
    @collection.fetch
      reset: true
      data:
        offset: @collection.offset
        limit: @collection.limit
        order: @collection.order
        sort_by: @collection.sort_by

class App.Views.AlertGrid extends Backgrid.Grid
  initialize: (options) ->
    super
      collection:options.collection
      columns: @alertColumns()

  alertColumns: ->
    [
      name: ''
      cell: Backgrid.Extension.SelectRowCell.extend
        onChange: (e) ->
          isSelected = $(e.target).is(':checked')
          $(e.target).closest('tr').toggleClass('is-selected', isSelected)
      headerCell: 'select-all'
    ,
      name: 'id'
      label: 'ID'
      cell: Backgrid.UriCell.extend
        render: ->
          Backgrid.UriCell.prototype.render.call(this)
          @$('a').attr('href', "/alerts/#{@model.id}").removeAttr('target')
          this
      sortable: true
      editable: false
      headerCell: CustomSortHeaderCell
    ,
      name: 'created_on'
      label: 'Created On'
      cell: Backgrid.StringCell.extend
        render: ->
          Backgrid.StringCell.prototype.render.call(this)
          dateStr = moment(@model.get('created_on')).format('ddd MMM DD HH:mm')
          @$el.text(dateStr)
          this
      sortable: false
      editable: false
    ,
      name: 'description'
      label: 'Description'
      cell: 'string'
      sortable: false
      editable: false
    ,
      name: 'assigned_to'
      label: 'Assigned To'
      cell: 'string'
      sortable: true
      editable: false
      headerCell: CustomSortHeaderCell
    ,
      name: 'status'
      label: 'Status'
      cell: 'string'
      sortable: false
      editable: false
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
            reset: true
            data:
              limit: @collection.limit
              offset: 0
          @$el.modal('hide')
          @undelegateEvents()
        error: ->
          console.error 'there was an error'
