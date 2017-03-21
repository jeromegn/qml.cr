import QtQuick 2.5
import QtQuick.Controls 1.4
import LineNumbers 0.0

ApplicationWindow {
  visible: true
  width: 800
  height: 600
  title: "Editor!"

  LineNumbers {
    id: hola
    property int yolo
    yolo: 1
  }
    
  Rectangle {
    id: lineColumn
    property int rowHeight: textarea.font.pixelSize + 3
    color: "#f2f2f2"
    width: 50
    height: parent.height
    Rectangle {
      height: parent.height
      anchors.right: parent.right
      width: 1
      color: "#ddd"
    }
    Column {
      y: -textarea.flickableItem.contentY + 4
      width: parent.width
      
      Repeater {
        model: Math.max(textarea.lineCount + 2, (lineColumn.height/lineColumn.rowHeight) )
        delegate: Text {
          id: text
          color: "#666"
          font: textarea.font
          width: lineColumn.width
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          height: lineColumn.rowHeight
          renderType: Text.NativeRendering
          text: index
        }
      }
    }
  }
  TextArea {
    id: textarea
    anchors.left: lineColumn.right
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    wrapMode: TextEdit.NoWrap
    frameVisible: false
  }
}