class App.Models.ContactMethod extends Backbone.Model
  url: ->
    if @id
      "/api/v1/users/#{@get('user_id')}/contact_methods/#{@id}.json"
    else
      "/api/v1/users/#{@get('user_id')}/contact_methods.json"
  defaults:
    label: null
    address: null
  toJSON: ->
    { contact_method: @attributes }
  toString: ->
    "#{@get('address')} (#{@get('label')})"
