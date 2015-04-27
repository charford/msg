Meteor.startup ->
  if not SessionAmplify.get 'current_user'
    SessionAmplify.set 'current_user', Meteor.uuid()
  if not SessionAmplify.get 'currently_editing'
    SessionAmplify.set 'currently_editing', []

Template.registerHelper 'panelStyle', (type)->
  switch type
    when 'mad' then 'danger'
    when 'sad' then 'warning'
    when 'glad' then 'success'

Template.board.helpers
  categories: ->
    ['mad','sad','glad']
