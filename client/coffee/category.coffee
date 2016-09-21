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
    query =
      $and: [
        { board_id: Session.get('board_id') }
        { type: @.toString() }
        { $or: [
          { user_id: SessionAmplify.get('current_user') }
          { content: $exists: true }
        ] }
      ]
    posts = Posts.find query, sort: rank: 1
    if posts.count() > 0
      return posts
    false
  title: ->
    @.charAt(0).toUpperCase() + @.slice(1)
  count: (type)->
    Posts.find(type: type, content: $ne: null).count()
