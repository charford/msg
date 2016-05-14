hooksObject =
  onSuccess: (formType, result)->
    currently_editing = SessionAmplify.get 'currently_editing'
    currently_editing.splice currently_editing.indexOf(result), 1
    SessionAmplify.set 'currently_editing', currently_editing

AutoForm.addHooks(null, hooksObject)

Template.post.events

  'click p': (e,t)->
    currently_editing = SessionAmplify.get('currently_editing')
    if @user_id is SessionAmplify.get('current_user')
      if currently_editing.indexOf(@_id) is -1
        currently_editing.push(@_id)
        SessionAmplify.set 'currently_editing', currently_editing

Template.post.helpers

  displayPost: ->
    @content or @user_id == SessionAmplify.get 'current_user'

  editMode: ->
    if @user_id != SessionAmplify.get 'current_user'
      return false
    if not @content or @content.trim().length == 0
      return true
    return SessionAmplify.get('currently_editing').indexOf(@_id) > -1

  notMyPost: ->
    @user_id != SessionAmplify.get 'current_user'

  myPost: ->
    @user_id == SessionAmplify.get 'current_user'

Template.post.rendered = ->

  $('.sortable').sortable
    start: (e,ui)->
      ui.placeholder.height ui.item.height()
    placeholder: 'sortablePlaceholder'
    connectWith: '.sortable'
    cancel: '.disable-sort-item'
    handle: '.handle'
    cursor: 'move'
    update: (e)->
      posts = []
      type = $(this).attr('id')
      $(this).find('li').each ->
        posts.push
          post_id: Blaze.getData(this)._id
          rank: $(this).index()
          type: type

      Meteor.call 'updatePostRanks', posts, (err,res)->
        if err
          console.log err
