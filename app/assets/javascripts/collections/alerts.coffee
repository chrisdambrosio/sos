class App.Collections.Alerts extends Backbone.Collection
  model: App.Models.Alert
  initialize: (models, options) ->
    @url = "/api/v1/alerts.json"
  parse: (response) ->
    @total = response.meta.total
    @limit = response.meta.limit
    @offset = response.meta.offset
    @pages = Math.ceil(@total / @limit)
    @page = Math.floor(@offset / @limit) + 1
    response.alerts
  fetch: (options) ->
    options.data = _.defaults(options.data, @fetchDefaults())
    super(options)
  fetchDefaults: ->
      limit: @limit
      offset: @offset
      order: @order
      sort_by: @sort_by
