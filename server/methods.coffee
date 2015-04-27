Meteor.methods
  createBoard: ->
    doc =
      date_created: new Date
    Boards.insert doc, (err,res)->
      if err
        console.log err
      return res

  createPost: (board_id, user_id, type)->
    doc =
      board_id: board_id
      user_id: user_id
      type: type
      rank: Posts.find(board_id: board_id).count() + 1
    Posts.insert doc, (err,res)->
      if err
        console.log err
      return res

  updatePost: (post_id, content)->
    doc =
      content: content
      draft: content
    Posts.update post_id, $set: doc, (err,res)->
      if err
        console.log err
      return res

  updateDraft: (post_id, draft)->
    doc =
      draft: draft
    Posts.update post_id, $set: doc, (err,res)->
      if err
        console.log err
      return res

  updatePostRanks: (posts)->
    for i of posts
      doc =
        type: posts[i].type
        rank: posts[i].rank
      Posts.update posts[i].post_id, $set: doc, (err,res)->
        if err
          console.log err

  removePost: (post_id)->
    Posts.remove post_id, (err,res)->
      if err
        console.log err
      return res
