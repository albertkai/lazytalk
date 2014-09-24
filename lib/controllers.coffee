@Lazytalk = {

  showIntLoader: ->

    @loader.red.show()
    $('#int-loader').addClass('_visible')

  hideMessageLoader: ->
    $('#int-loader').removeClass('_visible')
    Meteor.setTimeout =>
      @loader.red.hide()
    , 500

  notify: (header, text, type)->
    if type is 'success'
      markup = '<div class="notification-cont _success"><div><i class="fa fa-check"></i></div><div><h4>' + header + '</h4><p>' + text + '</p></div></div>'
    else if type is 'error'
      markup = '<div class="notification-cont _error"><div><i class="fa fa-times"></i></div><div><h4>' + header + '</h4><p>' + text + '</p></div></div>'
    $('body').prepend(markup)
    Meteor.setTimeout ->
      $('.notification-cont').addClass '_opened'
    , 100
    setTimeout ->
      $('.notification-cont').removeClass '_opened'
      setTimeout ->
        $('.notification-cont').remove()
      , 400
    , 2000

  media: {

    record: ->

      console.log 'Start recording'
      MainCtrl.stateRecording()
      @sendStatus('recording')
      @getAudio()

    sendStatus: (status)->

      #Sending status over meteor streams

    getAudio: ->
      console.log 'Getting audio!'

    loadRecord: (file)->

      MainCtrl.stateRecorded()

    sendRecord: (file)->

      Meteor.call 'uploadFile', file, (err, fileName)->
        if err
          console.log err
          Meteor.notify 'Упс', 'Какая-то беда нас сервере', 'error'
        else
          Meteor.call 'sendMessage', fileName, (error, res)->
            if error
              console.log error
            else
              console.log 'Все круто! Сообщение отправлено!'
              MainCtrl.stateSent()

    player: {

      play: ()->

        console.log 'play audio'

      pause: ()->

        console.log 'pausing audio'

      repeat: ()->

        console.log 'repeating'

    }


  }

}