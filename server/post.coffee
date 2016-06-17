@Post =

  create: (doc)->
    Posts.insert doc, (err,res)->
      if err
        console.log err
      return res

  update: (doc, doc_id)->
    if doc.$set?.content?.trim().length > 0 or doc.$addToSet?.votes
      Posts.update doc_id, doc, (err,res)->
        if err
          console.log err
    else
      Posts.remove doc_id, (err,res)->
        if err
          console.log err
    return doc_id
