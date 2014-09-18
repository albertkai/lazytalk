Template.settings.events {
  'click header .toggle-tab': (e)->
    SettingsCtrl.tabs.goTo $(e.currentTarget).closest('div').index()
    $('#settings').addClass '_opened'
    $('header  .toggle-tab').addClass '_visible'
    $('header  .close').removeClass '_visible'
    $(e.currentTarget).siblings('.close').addClass '_visible'
    $(e.currentTarget).removeClass '_visible'
    $(e.currentTarget).siblings('.close').addClass '_visible'
    setTimeout ->
      $('#settings .tabs').addClass '_transition'
    , 400

  'click header .close': (e)->
    $('#settings').removeClass '_opened'
    $('header  .toggle-tab').addClass '_visible'
    $('header  .close').removeClass '_visible'
    $('#settings .tabs').removeClass '_transition'

  'click .item': (e)->
    $(e.currentTarget).toggleClass '_interact'

  'click #logout': ->
    Meteor.logout()

  'input #user-settings .inputs input[type="text"]': (e)->
    SettingsCtrl.updateInfo(e)

}

Template.settings.rendered = ->

  SettingsCtrl.tabs.init()
  SettingsCtrl.tabs.goTo(2)


@SettingsCtrl = {

  tabs: {
    init: ->
      windowWidth = $('body').width()
      $('.tabs').width(windowWidth * 4 + 10)
      $('.tab').width(windowWidth)
    goTo: (index)->
      console.log index
      left = -($('body').width() * index) + 'px'
      $('#settings .tabs').css('left', left)
  }

  updateCalls: (e)->

    if $(e.currentTarget).closest('.rdo').data('value') is 'all'
      body = {
        all: true
        onlyFriends: false
      }
    else if $(e.currentTarget).closest('.rdo').data('value') is 'onlyFriends'
      body = {
        all: false
        onlyFriends: true
      }
    Meteor.call 'updateAppSettings', {type: 'calls', body: body}, (err, res)->
      if err
        console.log err
      else
        console.log 'Настройки звонков обновлены!'

  updateNotifications: (e)->

    body = {

      messages: $('.chckbx[data-value="messages"]').hasClass '_active'
      requests: $('.chckbx[data-value="requests"]').hasClass '_active'
      notify: $('.chckbx[data-value="notify"]').hasClass '_active'

    }

    Meteor.call 'updateAppSettings', {type: 'notifications', body: body}, (err, res)->
      if err
        console.log err
      else
        console.log 'Настройки обновлений обновлены! Пардон за каламбур=)'

  updatePhoneClose: (e)->

    body = $('.switcher[data-name="phone-close"]').hasClass '_active'

    Meteor.call 'updateAppSettings', {type: 'phoneCloseMode', body: body}, (err, res)->
      if err
        console.log err
      else
        if body
          console.log 'Режим поднесения включен!'
        else
          console.log 'Режим поднесения выключен!'

  infoTimeout: null

  updateInfo: (e)->
    $this = $(e.currentTarget)
    $status = $this.closest('div').find('.status')
    $status.addClass '_waiting'
    if @infoTimeout
      clearTimeout(@infoTimeout)
    @infoTimeout = setTimeout ->
      value = $this.val()
      fieldName = $this.attr('id')
      Meteor.call 'updateInfo', fieldName, value, (err, res)->
        if err
          $status.removeClass '_waiting'
          console.log err
        else
          console.log 'Поле ' + fieldName + ' обновлено!'
          $status.removeClass('_waiting').addClass('_done')
          setTimeout ->
            $status.removeClass('_done')
          , 1500
    , 1000






}