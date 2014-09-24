@recorder = null

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
    MainCtrl.player.play()

  'timeupdate #audio': (e)->
    MainCtrl.player.setWidth(e)

  'click #pause-message': ->
    $target = $('#main .interact .play')
    $target.removeClass '_playing'
    $target.addClass '_paused'
    MainCtrl.player.pause()

  'click #play-record': ->
    $target = $('#main .interact .recorded')
    $target.removeClass '_paused'
    $target.addClass '_playing'

  'click .message .handle': (e)->
    MainCtrl.player.setPosition(e)

  'click #pause-record': ->
    $target = $('#main .interact .recorded')
    $target.removeClass '_playing'
    $target.addClass '_paused'

  'click #record-message': ->
    MainCtrl.stateRecording()
    startRecording()

  'click #stop-record': ->
    MainCtrl.stateRecorded()
    completeRecording()

  'click #send-message': ->
    MainCtrl.stateLoading()
    setTimeout ->
      MainCtrl.stateSent()
    , 1500

  'pro'

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

  countRequests: (req)->
    if req
      if req.length is 0
        ''
      else
        req.length
}

Template.thread.rendered = ->


  Lazytalk['loader'] = {}
  Lazytalk.loader['red'] = new CanvasLoader('int-loader')
  Lazytalk.loader['red'].setColor('#f05c53')
  Lazytalk.loader['red'].setDiameter(80)
  Lazytalk.loader['red'].setDensity(10)
  Lazytalk.loader['red'].setRange(2)
  Lazytalk.loader['red'].setFPS(8)
  MainCtrl.player.init()
  setupMedia()




@MainCtrl = {


  player: {
    init: ->
      audio = $('#audio').get(0)


    setWidth: (e)->
      audio = $('#audio').get(0)
      $cont = $('.interact').find('.play').find('.message')
      $handle = $cont.find('.position')
      percentage = audio.currentTime / audio.duration
      $handle.css('width', Math.floor($cont.width() * percentage) + 'px')
      @setTime()

    setPosition: (e)->
      audio = $('#audio').get(0)
      $cont = $('.interact').find('.play').find('.message')
      $handle = $cont.find('.position')
      offset = e.offsetX || e.originalEvent.layerX
      percentage = offset / $cont.width()
      newTime = audio.duration * percentage
      audio.currentTime = Math.floor newTime
      $handle.css('width', Math.floor($cont.width() * percentage) + 'px')
      @setTime()

    setTime: ->
      current = moment.duration(Math.round(audio.currentTime), "seconds").format("mm:ss")
      total = moment.duration(Math.round(audio.duration), "seconds").format("mm:ss")
      $('.interact').find('.play').find('.time').find('span:nth-child(1)').html(current)
      $('.interact').find('.play').find('.time').find('span:nth-child(2)').html(total)

    setAudio: (blob)->

      @audio.src = blob

    play: ->
      console.log 'playing'
      $('#audio').get(0).play()
    pause: ->
      console.log 'pausing'
      $('#audio').get(0).pause()
  }

  stateRecord: ->

    @clearStyles()
    $('#main .interact').addClass '_record'

  statePlay: ->

    @clearStyles()
    $('#main .interact').addClass '_play'
    setTimeout ->
      $('#main .interact .play').addClass '_finished'
      ThreadsStream.emit Session.get('openedUserId'), Meteor.userId(), 'listened'
    , 2000
    ThreadsStream.emit Session.get('openedUserId'), Meteor.userId(), 'listening'

  stateRecording: ->

    @clearStyles()
    $('#main .interact').addClass '_recording'
    ThreadsStream.emit Session.get('openedUserId'), Meteor.userId(), 'recording'

  stateRecorded: ->

    @clearStyles()
    $('#main .interact').addClass '_recorded'

  stateLoading: ->

    @clearStyles()
    $('#main .interact').addClass '_loading'
    Lazytalk.loader.red.show()
    ThreadsStream.emit Session.get('openedUserId'), Meteor.userId(), 'sending'

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

  streamNotify: (type)->

    if type is 'recording'
      @stateUserRecording()

  recorder: null

}

#
#class @Recorder
#
#  @audioContext : null
#  @audioInput: null
#  @realAudioInput: null
#  @inputPoint: null
#  @audioRecorder: null
#  @rafID: null
#  @recIndex: 0
#
#  constructor: (@settings)->
#
#    window.AudioContext = window.AudioContext || window.webkitAudioContext
#    @constructor.audioContext = new AudioContext()
#    console.log 'контекст:'
#    console.log @constructor.audioContext
#    @constructor.inputPoint = @constructor.audioContext.createGain()
#    console.log 'инпут:'
#    console.log @constructor.inputPoint
#
#    @constructor.realAudioInput = @constructor.audioContext.createMediaStreamSource(stream)
#    @constructor.audioInput = @constructor.realAudioInput
#    @constructor.audioInput .connect(@constructor.inputPoint)
##    @constructor.audioInput = convertToMono( input )
#
#    @constructor.audioRecorder = new Recorder( @inputPoint , {workerPath: '/workers/recorderWorker.js'})
#
#  start: ->
#
#    @audioRecorder.record()
#
#  stop: ->
#
#    @audioRecorder.stop()




supportsMedia = ->
  !!(navigator.getUserMedia || navigator.webkitGetUserMedia ||navigator.mozGetUserMedia || navigator.msGetUserMedia)

navigator.getUserMedia = navigator.getUserMedia ||navigator.webkitGetUserMedia ||navigator.mozGetUserMedia ||navigator.msGetUserMedia

window.URL = window.URL || window.webkitURL


window.AudioContext = window.AudioContext || window.webkitAudioContext


mediaStream = null
audioContext = null
audioRecorder = null

setupMedia = ->
  if supportsMedia()
    audioContext = new AudioContext()

    navigator.getUserMedia {video: false, audio: true}, (localMediaStream)->
      audioInput = audioContext.createMediaStreamSource(localMediaStream)
      audioGain = audioContext.createGain()
      audioGain.gain.value = 0
      audioInput.connect(audioGain)
      audioGain.connect(audioContext.destination)

      audioRecorder = new Recorder(audioInput)
      mediaStream = localMediaStream
      mediaInitialized = true
    , (e)->
      console.log 'some shit:('


#// template event handlers
#Template.record.events = {
#  'click #start-recording': function (e) {
#  console.log("click #start-recording");
#e.preventDefault();
#
#if (!Meteor.user()) {
#  // must be the logged in user
#  console.log("\tNO USER LOGGED IN");
#  return;
#}
#document.getElementById('stop-recording').disabled = false;
#document.getElementById('start-recording').disabled = true;
#startRecording();
#},
#'click #stop-recording': function (e) {
#console.log("click #stop-recording");
#e.preventDefault();
#
#document.getElementById('stop-recording').disabled = true;
#document.getElementById('start-recording').disabled = false;
#stopRecording();
#}
#};


startRecording = ->
  console.log("Begin Recording")

  audioRecorder.record()

stopRecording = ()->
  console.log("End Recording");
  recording = false


completeRecording = ()->
  audioRecorder.stop()

  user = Meteor.user();
  if !user
    console.log("completeRecording - NO USER LOGGED IN")
    return
  console.log("completeRecording: " + user._id)

  audioRecorder.exportWAV (audioBlob)->
    BinaryFileReader.read audioBlob, (err, fileInfo)->
      blob = new Blob([fileInfo.file], {type: fileInfo.type})
      $('#audio').get(0).src = window.URL.createObjectURL(blob)
      console.log("Audio uploaded")


#  mediaStream.stop()
  console.log 'recordStoped'


BinaryFileReader = {
  read: (file, callback)->
    reader = new FileReader

    fileInfo = {
      name: file.name,
      type: file.type,
      size: file.size,
      file: null
    }

    reader.onload = ()->
      fileInfo.file = new Uint8Array(reader.result)
      callback(null, fileInfo)
    reader.onerror = ()->
      callback(reader.error)
    reader.readAsArrayBuffer(file)

}




