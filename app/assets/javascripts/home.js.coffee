# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#$ ->
  #$('#new-alert-dialog').on 'shown', ->
    #resetNewAlertForm()
    #$('.chzn-select').append('<option />').chosen()
    #$.getJSON '/api/v1/users.json', (data) ->
      #for user in data.users
        #$('.chzn-select')
          #.append("<option value=\"#{user.id}\">#{user.name}</option>")
          #.trigger("liszt:updated")
  #$('#new-alert-dialog .submit').on 'click', ->
    #newUser =
      #assigned_to: parseInt($('select[name=recipient]').val())
      #description: $('#new-alert-dialog input[name=description]').val()
      ##details: $('#new-alert-dialog textarea[name=details]').val()
    #$.ajax '/api/v1/alerts.json',
      #data: JSON.stringify(alert:newUser)
      #contentType: 'application/json'
      #type: 'POST'
    #console.log newUser
    #$('#new-alert-dialog').modal('hide')
    #console.log 'submitted'

#resetNewAlertForm = ->
  #$('#new-alert-dialog .chzn-select').empty()
  #$('#new-alert-dialog input[name=description]').val('')
  #$('#new-alert-dialog textarea[name=details]').val('')
