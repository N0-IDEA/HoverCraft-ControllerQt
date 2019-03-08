import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4

Rectangle{
    property int initialWidth: initWidth
    property int initialHeight: initHeight
    property color colorGlow: Material.color(Material.DeepOrange)
    readonly property string servoName: name
    Layout.preferredHeight: initialHeight
    Layout.preferredWidth:  initialWidth
    color:"transparent"
    //border.color: "red"
Row {
    id: rowServo
    anchors.fill: parent
    anchors.verticalCenter: parent.verticalCenter;
    spacing: (initialWidth - servoName.width) *0.05
    leftPadding: (initialWidth - servoName.width) *0.05
    GlowingLabel { id: servoName; text: "servoName"; anchors.verticalCenter: parent.verticalCenter; color: "white"; font.pixelSize:  24 }
    Column {
        id: column
        anchors.verticalCenter: parent.verticalCenter;
        Slider {
            id: control
            from: -0.9
            value: 0
            to: 0.9
            background: Rectangle {
                id: backSlider
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: (initialWidth - servoName.width) * 0.8
                implicitHeight: 2
                radius: 2
                color: Material.color(Material.DeepOrange)
                Rectangle {
                    width: control.visualPosition * parent.width
                    height: parent.height
                    color: Material.color(Material.DeepOrange)
                    radius: 2
                }
            }
            handle: Rectangle {
                id: handleSlider
                x: control.visualPosition * (control.availableWidth + width) - control.leftPadding
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: (initialWidth - servoName.width)*0.025
                implicitHeight: (initialWidth - servoName.width)*0.06
                radius: 6
                color: Material.color(Material.DeepOrange)
                border.color: setGlowBorder(control)
                layer.effect: CustomGlow { color: Material.color(Material.DeepOrange)}
              //  onXChanged: {console.log(handleSlider.x)}
                function setGlowBorder(control){ layer.enabled = control.pressed; return control.pressed ? "#f0f0f0" :Material.color(Material.DeepOrange) }
            }
        }
        Rectangle {
            color: "transparent"
            height: control.height
            width: control.width
            GlowingLabel {
                id: leftTextDeg
                property color colorGlow: Material.color(Material.DeepOrange)
                color: "white"
                text: "-90"
                anchors.left: parent.left
            }
            GlowingLabel {
                id: glowingLabel
                property color colorGlow: Material.color(Material.DeepOrange)
                color: "white"
                text: "0"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            GlowingLabel {
                property color colorGlow: Material.color(Material.DeepOrange)
                color: "white"
                text: "90"
                anchors.right: parent.right }
        }
    }
}
}















/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

