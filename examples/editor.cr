require "../src/qml"
require "./editor/line_numbers"

QML.run do |app|
  app.load path: Dir.current + "/examples/editor.qml"
end