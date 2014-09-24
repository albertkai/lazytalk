Meteor.methods {

  'addToBan': (id)->

    if id isnt Meteor.user()._id
      bannedUser = Meteor.users.findOne({'_id': id})
      user = {
        id: bannedUser._id
        first_name: bannedUser.profile.first_name
        last_name: bannedUser.profile.last_name
        username: bannedUser.profile.username
        avatar: bannedUser.profile.avatar
      }
      Meteor.users.update {'_id': Meteor.user()._id}, {$push: {'profile.banList': user}}

  'removeFromBan': (id)->

    Meteor.users.update {'_id': Meteor.user()._id}, {$pull: {'profile.banList': {'id': id}}}

  'addFriend': (id)->

    console.log id

    requestedUser = Meteor.users.findOne({'_id': id})
    console.log requestedUser

    you = {
      id: Meteor.user()._id
      first_name: Meteor.user().profile.first_name
      last_name: Meteor.user().profile.last_name
      username: Meteor.user().profile.username
      avatar: Meteor.user().profile.avatar
    }
    user = {
      id: requestedUser._id
      first_name: requestedUser.profile.first_name
      last_name: requestedUser.profile.last_name
      username: requestedUser.profile.username
      avatar: requestedUser.profile.avatar
    }
    if _.find(requestedUser.profile.friends.requested, (user)->user.id is Meteor.user()._id)
      Meteor.users.update {'_id': Meteor.userId()}, {$push: {'profile.friends.list': user}}
      Meteor.users.update {'_id': Meteor.userId()}, {$pull: {'profile.friends.requests': {'id': id}}}
      Meteor.users.update {'_id': id}, {$push: {'profile.friends.list': you}}
      Meteor.users.update {'_id': id}, {$pull: {'profile.friends.requested': {'id': Meteor.user()._id}}}
    else
      if !_.find(requestedUser.profile.friends.requests, (user)->user.id is Meteor.user()._id)
        Meteor.users.update {'_id': Meteor.user()._id}, {$push: {'profile.friends.requested': user}}
        Meteor.users.update {'_id': id}, {$push: {'profile.friends.requests': you}}

  'deleteFriend': (id)->

    Meteor.users.update {'_id': Meteor.user()._id}, {$pull: {'profile.friends.list': {'id': id}}}
    Meteor.users.update {'_id': id}, {$pull: {'profile.friends.list': {'id': Meteor.user()._id}}}



}