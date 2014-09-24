Router.map ->

  @route '/', {

    waitOn: ->

      Meteor.subscribe('allUsers')

    action: ->

      if !Meteor.userId()

        @render 'home'

      else

        @redirect '/' + Meteor.userId()

  }

  @route 'main', {
    template: 'mainLayout'
    path: '/:userId'
    onAfterAction: ->
      Session.set 'openedUserId', @params.userId
      if $('.wrap').length > 0
        $('#contacts').removeClass '_opened'
        $('#threads').removeClass '_opened'
    data: ->
      user = Meteor.users.findOne({'_id': @params.userId})
      {
        user: user
      }
  }

Router.onBeforeAction ->
  if !Meteor.userId()
    @redirect '/'