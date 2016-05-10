Template.footer.helpers
  exportLink: ->
    if Router.current().route.getName() == "board"
      return '/b/' + Session.get('current_board_id')
    false
