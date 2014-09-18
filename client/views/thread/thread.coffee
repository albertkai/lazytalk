Template.main.events {

  'click #open-contacts': (e)->
    e.preventDefault()
    $('#contacts').addClass '_opened'

  'click #open-threads': (e)->
    e.preventDefault()
    $('#threads').addClass '_opened'

  'click #play-message': ->
    $target = $('#main .interact .play')
    $target.removeClass '_paused'
    $target.addClass '_playing'

  'click #pause-message': ->
    $target = $('#main .interact .play')
    $target.removeClass '_playing'
    $target.addClass '_paused'

  'click #play-record': ->
    $target = $('#main .interact .recorded')
    $target.removeClass '_paused'
    $target.addClass '_playing'

  'click #pause-record': ->
    $target = $('#main .interact .recorded')
    $target.removeClass '_playing'
    $target.addClass '_paused'

  'click #record-message': ->
    MainCtrl.stateRecording()

  'click #stop-record': ->
    MainCtrl.stateRecorded()

  'click #send-message': ->
    MainCtrl.stateLoading()
    setTimeout ->
      MainCtrl.stateSent()
    , 1500

  'click .user .status': ->
    MainCtrl.stateUserRecording()
    setTimeout ->
      MainCtrl.statePlay()
    , 2000

  'click .user img': ->

    MainCtrl.showModal()

  'click #rec-new-message': ->

    MainCtrl.stateRecord()

}


Template.main.helpers {
  usersPage: (id)->
    if Meteor.userId() is id
      true
    else
      false
}

Template.thread.rendered = ->


  Lazytalk['loader'] = {}
  Lazytalk.loader['red'] = new CanvasLoader('int-loader')
  Lazytalk.loader['red'].setColor('#f05c53')
  Lazytalk.loader['red'].setDiameter(80)
  Lazytalk.loader['red'].setDensity(10)
  Lazytalk.loader['red'].setRange(2)
  Lazytalk.loader['red'].setFPS(8)





@MainCtrl = {

  stateRecord: ->

    @clearStyles()
    $('#main .interact').addClass '_record'

  statePlay: ->

    @clearStyles()
    $('#main .interact').addClass '_play'
    setTimeout ->
      $('#main .interact .play').addClass '_finished'
    , 2000

  stateRecording: ->

    @clearStyles()
    $('#main .interact').addClass '_recording'

  stateRecorded: ->

    @clearStyles()
    $('#main .interact').addClass '_recorded'

  stateLoading: ->

    @clearStyles()
    $('#main .interact').addClass '_loading'
    Lazytalk.loader.red.show()

  stateSent: ->

    @clearStyles()
    Lazytalk.loader.red.hide()
    $('#main .interact').addClass '_sent'
    setTimeout =>
      @stateRecord()
    , 2000


  stateUserRecording: ->

    @clearStyles()
    $('#main .interact').addClass '_user-recording'
    $('.user').addClass '_recording'

  clearStyles: ->

    $target = $('#main .interact')
    $target.removeClass '_record'
    $target.removeClass '_recording'
    $target.removeClass '_recorded'
    $target.removeClass '_sent'
    $target.removeClass '_user-recording'
    $target.removeClass '_play'
    $target.removeClass '_loading'
    $('.user').removeClass '_recording'

  showModal: ->

    $('.modal-over').addClass '_opened'

}