##Meteor.users.find().fetch().forEach (u)->
##  Meteor.users.remove u._id
#
#if Threads.find().count() > 0
#  Threads.find().fetch().forEach (thread)->
#    id = thread._id
#    Threads.remove id
#
#if Threads.find().count() is 0
#  Threads.insert {
#    statuses: [
#      {
#        id: 'tWxN6KcnPN2wr2c5S',
#        status: 'recording'
#      },
#      {
#        id: 'PJT9sqDLfYad6q628',
#        status: 'listening'
#      },
#    ]
#    members: [
#      {
#        id: 'tWxN6KcnPN2wr2c5S',
#        firstName: 'Артур',
#        lastName: 'Клименко',
#        username: 'klim'
#        avatar: 'http://graph.facebook.com/1276327615/picture/?type=large'
#      },
#      {
#        id: 'PJT9sqDLfYad6q628',
#        firstName: 'Альберт',
#        lastName: 'Кайгородов',
#        avatar: 'http://graph.facebook.com/1276327615/picture/?type=large'
#        username: 'albertkai'
#      }]
#    lastMessage: {
#      date: 23464324
#      message: 'Приветствую!!'
#      type: 'text'
#    }
#    createdAt: 'Thu Aug 28 2014 18:40:56 GMT+0400 (MSK)'
#    type: 'private',
#    count: 0
#    total: 434
#  }
#
