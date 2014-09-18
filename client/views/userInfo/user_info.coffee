Template.userInfo.events {
  'click .close-modal': (e)->
    $(e.currentTarget).closest('.modal-over').removeClass '_opened'
}