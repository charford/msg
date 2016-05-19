Template.category.events
  'click .new-post-btn': (e,t)->
    Meteor.call 'createPost',
      Session.get('board_id'),
      SessionAmplify.get('current_user'),
      @.toString(),
      (err,res)->
        currently_editing = SessionAmplify.get 'currently_editing'
        currently_editing.push(res)
        SessionAmplify.set 'currently_editing', currently_editing

Template.category.helpers
  posts: ->
    Posts.find type: @.toString(),
      sort: rank: 1
  title: ->
    @.charAt(0).toUpperCase() + @.slice(1)
  count: (type)->
    Posts.find(type: type, content: $ne: null).count()
