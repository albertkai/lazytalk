Meteor.methods {

  uploadFile: (file)->

    s3 = new AWS.S3()

    buffer = new Buffer(file.data, 'binary')

    newName = do ->
      extention = _.last file.name.split('.')
      randomName = Random.id()
      randomName + '.' + extention

    origFile =  {
      Key: 'audio/' + newName
      ContentType: file.type
      Body: buffer
      Bucket: 'lazytalk'
    }

    f = new Future()

    s3.putObject origFile, (err, data)->
      if err
        console.log err
        f.return(false)
      else
        console.log 'object ' + file.name + ' with new name ' + newName + ' uploaded to S3! Congrats!'
        f.return(newName)

    f.wait()


  deleteFile: (file)->

    s3 = new AWS.S3()

    params = {
      Bucket: 'lazytalk'
      Key: 'audio/' + file
    }

    f = new Future()

    s3.deleteObject params, (err, data)->
      if (err)
        console.log(err, err.stack)
        f.return(false)
      else
        console.log('object ' + file + ' deleted from S3')
        f.return(true)

    f.wait()


  deleteFiles: (files)->

    if files.length > 0

      s3 = new AWS.S3()

      params = {
        Bucket: 'lazytalk',
        Delete: {
          Objects: []
        }
      }

      files.forEach (file)->
        obj = {}
        obj['Key'] = file
        params.Delete.Objects.push obj

      f = new Future()

      s3.deleteObjects params, (err, data)->
        if (err)
          console.log(err, err.stack)
          f.return(false)
        else
          console.log('objects ' + files + ' deleted from S3')
          f.return(true)

      f.wait()

    else

      console.log 'no files to delete'

      true

}