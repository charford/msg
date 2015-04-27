Template.index.events
  'click .btn-success': (e,t)->
    Meteor.call 'createBoard', (err,res)->
      if err
        console.log err
      else
        Router.go('/b/' + res)
