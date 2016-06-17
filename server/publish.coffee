Meteor.startup ->
  Posts._ensureIndex board_id: 1

Meteor.publish "board", (board_id)->
  Boards.find board_id

Meteor.publish "posts", (board_id, user_id)->
  query =
    $and: [
      { board_id: board_id }
      { $or: [
        { user_id: user_id }
        { content: $exists: true }
      ] }
    ]
  Posts.find query
