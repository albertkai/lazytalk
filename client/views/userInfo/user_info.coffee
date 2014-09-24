Template.userInfo.events {
  'click .close-modal': (e)->
    $(e.currentTarget).closest('.modal-over').removeClass '_opened'
}

Template.userInfo.helpers {

  userBanned: (id)->

    if Meteor.user()
      if _.find(Meteor.user().profile.banList, (user)->user.id is id)
        true
      else
        false

  isInFriends: (id)->

    if Meteor.user()
      if _.find(Meteor.user().profile.friends.list, (user)->user.id is id)
        true
      else
        false
}