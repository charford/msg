@Boards = new Mongo.Collection("boards")
@Posts = new Mongo.Collection("posts")
@Schemas = {}
@Schemas.Board = new SimpleSchema
  date_created:
    type: Date
@Schemas.Post = new SimpleSchema
  board_id:
    type: String
  user_id:
    type: String
  type:
    type: String
    allowedValues: ['mad','sad','glad']
  rank:
    type: Number
  content:
    type: String
    optional: true
    autoform:
      afFormGroup:
        label: false
  votes:
    type: [String]
    optional: true
@Boards.attachSchema @Schemas.Board
@Posts.attachSchema @Schemas.Post
