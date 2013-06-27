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
