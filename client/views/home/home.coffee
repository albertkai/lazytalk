Template.home.events {

  'click #login-buttons-facebook': ->
    console.log 'logging-in'
    Meteor.loginWithFacebook(requestPermissions: ['public_profile', 'email', 'user_friends'], (err, data)->console.log data)
}