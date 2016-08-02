Router.route '/b/:board_id.tsv', where: 'server'
  .get ->
    posts =
      mad: []
      sad: []
      glad: []
    
    Posts.find(board_id: @params.board_id).forEach (post)->
      posts[post.type].push post

    i = 0
    rows = '"mad"\t"sad"\t"glad"\n'
    while true
      row = ""
      for type in ['mad', 'sad', 'glad']
        if posts[type].length > i and posts[type][i]?.content
          row += '"' + posts[type][i].content + '"'
        else
          row += '""'
        if type != 'glad'
          row += "\t"
        else
          row += "\n"
      if row == '""\t""\t""\n'
        break
      rows += row
      i++
    @response.writeHead 200, 'Content-Disposition': 'attachment; filename=export.tsv'
    @response.end rows

Router.route '/b/:board_id.txt', where: 'server'
  .get ->
    posts =
      mad: []
      sad: []
      glad: []
    
    Posts.find({board_id: @params.board_id}, {sort: rank: 1}).forEach (post)->
      posts[post.type].push post

    rows = ""
    for type in ['mad', 'sad', 'glad']
      row = type + "\n\n"
      if posts[type].length > 0
        for post in posts[type]
          votes = 0
          if post.votes?.length?
            votes = '+' + post.votes.length
          if post.content
            row += "[" + votes + "] " + post.content + "\n"
        row += "\n"
      if row.length > 0
        rows += row
    @response.end rows
