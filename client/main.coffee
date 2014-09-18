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


}
