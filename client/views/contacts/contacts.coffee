Meteor.users.initEasySearch 'search'

EasySearch.createSearchIndex('search', {
  'field' : ['profile.first_name'],
  'collection' : Meteor.users,
  'limit' : 20
})

Template.contacts.events {
  'click header .back': ->

    $('#contacts').removeClass '_opened'

  'click .item > div:nth-child(2)': (e)->
    $(e.currentTarget).closest('.item').toggleClass '_interact'

  'click .item > div:nth-child(3)': (e)->
    targetId = $(e.currentTarget).closest('.item').data('id')
    Router.go '/' + targetId

  'click #add-friend': (e)->
    $('#contacts').find('.body').toggleClass '_shifted'
    $('#contacts').find('.find-friend').toggleClass '_visible'
    $('#contacts').find('.stripe').toggleClass '_visible'
    $(e.currentTarget).toggleClass '_opened'

  'click #add-to-friends': (e)->
    targetId = $(e.currentTarget).closest('.item').data('id')
    Meteor.call 'addFriend', targetId, (err, res)->
      if err
        console.log err
        Lazytalk.notify 'Упсики:(', 'Попробуйте позже, какая-то фигня..', 'error'
      else
        console.log 'Пользователю с id "' + targetId + '" отправлена заявка'
        Lazytalk.notify 'Ура!', 'Заявка отправлена', 'success'

  'click #accept-request': (e)->
    targetId = $(e.currentTarget).closest('.item').data('id')
    Meteor.call 'addFriend', targetId, (err, res)->
      if err
        console.log err
        Lazytalk.notify 'Упсики:(', 'Попробуйте позже..', 'error'
      else
        if Meteor.user().profile.friends.requests.length is 0
          $('#contacts .body').removeClass '_requests-list'
        console.log 'Пользователь с id "' + targetId + '" добавлен в друзья!'
        Lazytalk.notify 'Ура!', 'Вы теперь друзья!', 'success'


  'click #delete-friend': (e)->
    targetId = $(e.currentTarget).closest('.item').data('id')
    Meteor.call 'deleteFriend', targetId, (err, res)->
      if err
        console.log err
        Lazytalk.notify 'Упсики:(', 'Попробуйте позже, какая-то фигня..', 'error'
      else
        console.log 'Пользователь с id "' + targetId + '" удален из ваших контактов'
        Lazytalk.notify 'Да..', 'Пользователь удален из списка контактов:(', 'success'

  'click #open-requests': (e)->
    if Meteor.user().profile.friends.requests.length > 0
      $(e.currentTarget).toggleClass '_requests-opened'
      if $('#contacts .body').hasClass '_requests-list'
        $('#contacts .body').removeClass '_requests-list'
        $('.stripe').addClass '_visible'
      else
        $('#contacts .body').removeClass '_shifted'
        $('#contacts .body').addClass '_requests-list'
        $('.stripe').removeClass '_visible'
    else
      Lazytalk.notify 'Упс', 'У вас нет новых заявок', 'error'


}

Template.contacts.helpers {

  gotFriends: (friends)->
    if friends
      if friends.length > 0
        true
      else
        false

  countRequests: (req)->
    if req
      if req.length is 0
        ''
      else
        req.length

}

Template.contactsUserItem.helpers {

  getFriendStatus: (id)->
    requests = Meteor.user().profile.friends.requested
    friends = Meteor.user().profile.friends.list
    if _.find(friends, (i)->i.id is id)
      'in-friend-list'
    else
      if _.find(requests, (i)->i.id is id)
        'request-sent'
      else
        'add-to-friends'
}

