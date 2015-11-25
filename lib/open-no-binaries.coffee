path = require 'path'
isbinaryfile = require 'isbinaryfile'

module.exports = OpenNoBinaries =
  opener: null

  activate: (state) ->
    @opener = atom.workspace.addOpener (uri) ->
      # ignore protocols
      if /^[a-z-]+:\/\//.test(uri)
        return
      if isbinaryfile.sync(uri)
        atom.notifications.addInfo('Binary detected \'' + uri + '\'.')
        return false

  deactivate: ->
    @opener.dispose()
