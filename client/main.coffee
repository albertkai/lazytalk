Meteor.subscribe 'allUsers'
Meteor.subscribe 'threads'


UI.body.rendered = ->
  $('body').hammer()




Template.mainLayout.rendered = ->

  console.log 'Main layout rendering'

#  MainCtrl['loader']['white'] = new CanvasLoader('main-loader')
#  MainCtrl['loader']['white'].setColor('rgb(240, 92, 83)')
#  MainCtrl['loader']['white'].setDiameter(56)
#  MainCtrl['loader']['white'].setDensity(66)
#  MainCtrl['loader']['white'].setRange(1)
#  MainCtrl['loader']['white'].setFPS(51)


Template.mainLayout.events {

  'click .rdo>div': (e)->
    if !$(e.currentTarget).closest('.rdo').hasClass('_active')
      $(e.currentTarget).closest('.rdo').siblings('.rdo').removeClass '_active'
      $(e.currentTarget).closest('.rdo').addClass '_active'
      SettingsCtrl.updateCalls(e)

  'click .chckbx>div': (e)->
    $(e.currentTarget).closest('.chckbx').toggleClass '_active'
    SettingsCtrl.updateNotifications(e)

  'click .switcher': (e)->
    $(e.currentTarget).toggleClass '_active'
    SettingsCtrl.updatePhoneClose()

  'click .add-to-ban': ->

    Meteor.call 'addToBan', Session.get('openedUserId'), (err, res)->

      if err
        console.log err
      else
        console.log 'Пользователь с id "' + Session.get('openedUserId') + ' добавлен в бан'

  'click .remove-from-ban': ->

    Meteor.call 'removeFromBan', Session.get('openedUserId'), (err, res)->

      if err
        console.log err
      else
        console.log 'Пользователь с id "' + Session.get('openedUserId') + ' удален из бана'

  'click #top-logo': ->

    Router.go '/' + Meteor.userId()

  'swiperight #main': ->
    console.log 'swiped'



}
