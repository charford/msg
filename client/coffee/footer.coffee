Template.footer.helpers
  exportLink: ->
    if Router.current().route.getName() == "board"
      return location.pathname
    false
