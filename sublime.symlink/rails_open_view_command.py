import sublime
import sublime_plugin
import os
import re

class RailsOpenViewCommand(sublime_plugin.WindowCommand):

  extensions = (
    '.html.erb',
    '.erb',
    '.html.haml',
    '.haml',
    '.js.erb',
    '.js.haml'
  )

  def search(self, view, text):
    line = view.substr(view.line(text))

    if ("render" in line) or (" def " in line):
      self.get_view(view, text)

  def get_view(self, view, text):
    line = view.substr(view.line(text))
    current_file_path = view.file_name()
    is_controller = "controllers/" in current_file_path
    is_view = "views/" in current_file_path

    if is_controller:
      base = current_file_path.split('controllers/')
      base_path = base[0]
      if "def " in line:
        controller_name = base[-1].split("_controller")[0]
        view_name = re.findall(r'def\s(\w+)', line)[0]
        view_file_path = controller_name + "/" + view_name
      else:
        # TODO: parse render statement and open that file
        pass

    elif is_view:
      if "partial" in line:
        result = re.findall(r'render\s*\(?\s*\:?partial(\s*=>|:*)\s*["\'](.+?)["\']', line)
        partial_argument = result[0][1]
      else:
        result = re.findall(r'render\s*\(?\s*["\'](.+?)["\']', line)
        partial_argument = result[0]

      base = current_file_path.split('views/')
      base_path = base[0]

      if "/" in partial_argument:
        paths = partial_argument.split("/")
        partial_file = paths.pop()
        view_file_path = "/".join(paths) + "/_" + partial_file
      else:
        controller_name = base[-1].split("/")[0]
        view_file_path = controller_name + "/_" + partial_argument

    file_name_sans_extension = base_path + "views/" + view_file_path
    for ext in self.extensions:
      file_path = file_name_sans_extension + ext
      if os.path.exists(file_path):
        break

    self.window.open_file(file_path)


  def run(self):
    view = self.window.active_view()
    sel = view.sel()
    for text in sel:
      self.search(view, text)
