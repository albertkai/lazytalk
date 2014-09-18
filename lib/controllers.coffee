@Lazytalk = {

  showIntLoader: ->

    @loader.red.show()
    $('#int-loader').addClass('_visible')

  hideMessageLoader: ->
    $('#int-loader').removeClass('_visible')
    Meteor.setTimeout =>
      @loader.red.hide()
    , 500
}