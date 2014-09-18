Accounts.onCreateUser (options, user)->

  #Make it pretty mafaka

  #Generate user

  user['profile'] = {

    avatar: "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large"
    friends: {
      list: []
      requests: []
      requested: []
    }
    threads: {
      list: []
    }
    banList: []
    settings: {
      calls: {
        all: true
        onlyFriends: false
      }
      notifications: {
        messages: true
        requests: true
        notify: true
      }
      phoneCloseMode: true
    }
    info: {
      total: 0
      in: 0
      out: 0
      inCount: 0
      outCount: 0
    }

  }

  requested = ['email', 'gender', 'first_name', 'last_name', 'locale', 'friends', 'phone']
  requested.forEach (name)->
    user.profile[name] = user.services.facebook[name]

  user
