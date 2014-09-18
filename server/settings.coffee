Meteor.methods {

  'updateAppSettings': (options)->

    id = Meteor.user()._id

    query = {}
    query['profile.settings.' + options.type] = options.body

    Meteor.users.update {'_id': id}, {$set: query}

  'updateInfo': (fieldName, value)->

    id = Meteor.user()._id

    query = {}
    query['profile.' + fieldName] = value

    Meteor.users.update {'_id': id}, {$set: query}

}