@Threads = new Meteor.Collection('threads')

#Streams

@ThreadsStream = new Meteor.Stream('threadsStream')

if Meteor.isClient
  ThreadsStream.on Meteor.userId(), (type)->
    MainCtrl.streamNotify(type)

if Meteor.isServer
  ThreadsStream.permissions.write (eventName)->
    if @userId
      true

  ThreadsStream.permissions.read (eventName)->
    if @userId is eventName
      true