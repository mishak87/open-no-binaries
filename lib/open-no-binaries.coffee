path        = require 'path'
isbinaryfile= require 'isbinaryfile'
fs          = require 'fs-plus'
configs     = require './config-schema'

extension = (path) ->
    path.split('.').pop().toLowerCase()

fileBasename = (path) ->
    path.split('\\').pop()# path.substr(path.lastIndexOf('\\')).replace('\\','')


############################# CONFIGS #############################
arr_excluded = atom.config.get('open-no-binaries.excludeFileTypes.excluded') ? []

atom.config.onDidChange 'open-no-binaries.excludeFileTypes.excluded', ({newValue, oldValue}) ->
    arr_excluded = newValue

atom.config.onDidChange 'open-no-binaries.excludeFileTypes.enabled', ({newValue, oldValue}) ->
    if newValue
        arr_excluded = atom.config.get('open-no-binaries.excludeFileTypes.excluded') ? []
    else
        arr_excluded = []
###################################################################


module.exports = OpenNoBinaries =
    config: configs
    opener: null

    activate: (state) ->
        @opener = atom.workspace.addOpener (uri) ->
            # ignore protocols
            if /^[a-z-]+:\/\//.test(uri)
                return
            # check only files
            if not fs.isFileSync(uri)
                return false

            if extension(uri) not in arr_excluded and isbinaryfile.sync(uri)
                atom.notifications.addInfo("Binary Detected: '#{fileBasename(uri)}'")
                return false

        deactivate: ->
            @opener.dispose()
