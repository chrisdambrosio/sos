class App.Collections.ContactMethods extends Backbone.Collection
  model: App.Models.ContactMethod
  initialize: (models, options) ->
    @user = options.user
    @url = "/api/v1/users/#{@user.id}/contact_methods.json"
  parse: (response) ->
    response.contact_methods
