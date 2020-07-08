import sublime, sublime_plugin

class CloseOtherTabsCommand(sublime_plugin.WindowCommand):
  def run(self):
    window = self.window
    active_group = window.active_group()
    curr_view_id = window.active_view_in_group(active_group).id()

    for v in window.views_in_group(active_group):
      if v.id() == curr_view_id: continue
      window.focus_view(v)
      window.run_command("close")
