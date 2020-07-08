import sublime, sublime_plugin
import os

class DeleteActiveFileCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        confirmed = sublime.ok_cancel_dialog('Are you sure you want to delete the file?')
        if not confirmed:
            return
        os.remove(self.view.file_name())
        self.view.window().run_command('close')
