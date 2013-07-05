class App.Views.LogEntry extends Backbone.View
  initialize: ->
    @template = @getTemplate()
  tagName: 'tr'
  getTemplate: ->
    switch @model.get('action')
      when 'trigger'     then JST['templates/log_entries/trigger']
      when 'assign'      then JST['templates/log_entries/assign']
      when 'notify'      then JST['templates/log_entries/notify']
      when 'acknowledge' then JST['templates/log_entries/acknowledge']
      when 'resolve'     then JST['templates/log_entries/resolve']
  render: ->
    @$el.html(@template(@model.attributes))
    @$el.prepend("<td class=\"time\">#{@createdAt()}</td")
    this
  createdAt: ->
    time = @model.get('created_at')
    moment(time).format('ddd, MMM D YYYY, hh:mma') +
      " (#{moment(time).fromNow()})"

  channel: ->
    "the website" if @model.get('channel').type is 'website'
  agent: ->
    switch @model.get('agent').type
      when 'user'
        "<a href=\"/users/#{@model.get('agent').user.id}\">" +
          "#{@model.get('agent').user.name}</a>"
  user: ->
    "<a href=\"/users/#{@model.get('user').id}\">" +
          "#{@model.get('user').name}</a>"


class App.Views.LogEntries extends Backbone.View
  tagName: 'tbody'
  render: ->
    @$el.empty()
    @addAll()
    this
  addAll: =>
    @collection.forEach(@addOne)
  addOne: (model) =>
    view = new App.Views.LogEntry
      model: model
    @$el.append(view.render().el)
