Router.map ->

  @route '/', {

    waitOn: ->

      Meteor.subscribe('users')

    action: ->

      if !Meteor.userId()

        @render 'home'

      else

        @redirect '/' + Meteor.userId()

  }

  @route 'main', {
    template: 'mainLayout'
    path: '/:userId'
    data: ->
      user = Meteor.users.findOne({'_id': @params.userId})
      {
        user: user
      }
  }

Router.onBeforeAction ->
  if !Meteor.userId()
    @redirect '/'