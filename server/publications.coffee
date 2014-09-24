Meteor.publish 'allUsers', ->
  Meteor.users.find()