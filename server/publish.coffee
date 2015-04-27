Meteor.startup ->
  Posts._ensureIndex board_id: 1

Meteor.publish "board", (board_id)->
  Boards.find board_id

Meteor.publish "posts", (board_id)->
  Posts.find board_id: board_id
