import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../" as MainComponents

import QtGraphicalEffects 1.12

Rectangle{
    property string labelText: text
    property string labelColor: colorLabel
    color: "transparent"
    //border.color: Material.color(Material.DeepOrange)
    border.color: "white"
    property int cols: 12
    height: parent.height /externalRows
    Layout.preferredWidth: parent.width / 12 * cols
    Layout.preferredHeight: (parent.height - parent.rowSpacing*2)/ gridRepeater.rows
    Layout.columnSpan: cols

    Label {
        font.pixelSize:  20
        color: labelColor
        text: labelText
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    /*Item {
           id: src
           anchors.fill: parent

           Rectangle {
               id: myRectangle
               anchors.centerIn: parent
               height: parent.height-innerShadowID.radius
               width: parent.width - innerShadowID.radius
               color: "grey"
           }
       }
    InnerShadow {
        id: innerShadowID
          anchors.fill: src
          cached: true
          horizontalOffset: 0
          verticalOffset: 0
          radius: 16
          samples: 32
          color: Material.color(Material.DeepOrange)
          smooth: true
          source: src
      }*/
}
