# @joseramonc init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.

atom.workspace.onDidAddTextEditor (event) ->
  # Fold if opened file is ruby test file
  path = event.textEditor.getPath()
  if path? and path.indexOf('/test/') isnt -1 and path.indexOf('_test.rb') isnt -1
    event.textEditor.foldAllAtIndentLevel(1)
