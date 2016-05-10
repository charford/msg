Router.configure
  layoutTemplate: 'AppLayout'

Router.route '/',
  name: 'index'
  trackPageView: true

Router.route '/b/:board_id',
  name: 'board'
  trackPageView: true
  onBeforeAction: ->
    Session.set 'current_board_id', @params.board_id
    @next()
  waitOn: ->
    Session.set 'board_id', @params.board_id
    [
      Meteor.subscribe 'board', @params.board_id
      Meteor.subscribe 'posts', @params.board_id
    ]
