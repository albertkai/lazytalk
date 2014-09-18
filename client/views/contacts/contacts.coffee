Meteor.users.initEasySearch 'search'

EasySearch.createSearchIndex('search', {
  'field' : ['profile.first_name'],
  'collection' : Meteor.users,
  'limit' : 20
})

Template.contacts.events {
  'click header .back': ->

    $('#contacts').removeClass '_opened'

  'click .item': (e)->
    $(e.currentTarget).toggleClass '_interact'

  'click #add-friend': (e)->
    $('#contacts').find('.body').toggleClass '_shifted'
    $('#contacts').find('.find-friend').toggleClass '_visible'
    $('#contacts').find('.stripe').toggleClass '_visible'
    $(e.currentTarget).toggleClass '_opened'


}

Template.contacts.helpers {

  gotFriends: (friends)->
    if friends
      if friends.length > 0
        true
      else
        false

}