path = require 'path'
isbinaryfile = require 'isbinaryfile'
fs = require 'fs-plus'

module.exports = OpenNoBinaries =
  opener: null

  activate: (state) ->
    @opener = atom.workspace.addOpener (uri) ->
      # ignore protocols
      if /^[a-z-]+:\/\//.test(uri)
        return
      # check only files
      if not fs.isFileSync(uri)
        return false
      if isbinaryfile.sync(uri)
        atom.notifications.addInfo('Binary detected \'' + uri + '\'.')
        return false

  deactivate: ->
    @opener.dispose()
