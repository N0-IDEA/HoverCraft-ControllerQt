import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12



Rectangle {
    readonly property color colorLightGrey: "#888"
    readonly property color colorDarkGrey: "#333"
    readonly property color colorGlow: Material.color(Material.DeepOrange)//"#7CC1CC"
    readonly property string gridMain: idGrid
    readonly property string ppm: ppmValue
    readonly property string name: nameMotor
    property int rowsGlobal: globalRows
    id: alguno
    property int initialWidth: initWidth
    property int initialHeight: initHeight
    Layout.preferredHeight: initialHeight
    Layout.preferredWidth:initialWidth
   // border.color: parent.width > parent.height? "green" : "orange"
   // border.width: 1
    color: "transparent"
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: function () { console.log(alguno.width)} //parent.state = "PRESSED"; parent.visible = false;}
    }
    states: [ State { name: "moved"; when: mouseArea.pressed; PropertyChanges { target: alguno; x: 50; y: 50 } } ]
    /* transitions: [
        Transition {
            NumberAnimation { properties: "x,y"; duration: 1000 }
        }
    ]*/
    GridBase{
        id: grid
        columnSpacing: 0
        rowSpacing: 0
        Rectangle {
            Layout.minimumWidth:  Math.floor(parent.width / 10)*3
            Layout.minimumHeight:  parent.height
           // border.color: "red"
            color: "transparent"
            Column {
                width:  parent.width
                height:   parent.height /2
                Rectangle{
                    height: parent.parent.height/2
                    width: parent.parent.width
                   // border.color: "red"
                    color: "transparent"
                    GlowingLabel { anchors.centerIn: parent; text: name; color: "white"; font.pixelSize:  24 }
                }
                Rectangle{
                    height: parent.parent.height/2
                    width: parent.parent.width
                   // border.color: "red"
                    color: "transparent"
                    GlowingLabel { anchors.centerIn: parent; text: qsTr(String(ppm)); color: "white"; font.pixelSize: 24; Keys.onPressed: { if (event.key === Qt.UpArrow) {} }                    }
                }
            }
        }
        Rectangle {
            Layout.minimumWidth:  Math.floor(parent.width / 10)*5
            Layout.minimumHeight:  parent.height
            color: "transparent"
           // border.color: "red"
            EngineCanvas {
                Layout.minimumWidth:  Math.floor(parent.parent.width / 10)*5
                Layout.minimumHeight:  parent.parent.height
                anchors.centerIn: parent
                property string idVel: "engine12"
            }
        }
        Rectangle {
            Layout.minimumWidth:  Math.floor(parent.width / 10)*2
            Layout.minimumHeight: parent.height
           // border.color: "red"
            color: "transparent"
            Column {
                anchors.centerIn: parent
                anchors.top: parent.top
                width: Math.floor(parent.parent.width / 10)*2
                height: parent.parent.height

                Rectangle{
                    height: parent.height/2
                    width: parent.width
                   // border.color: "red"
                    color: "transparent"
                    VelCircle {
                        RotationAnimation on rotation { from: 0; to: 360; duration: 4000; running: true; loops: Animation.Infinite }
                        anchors.centerIn: parent; property string idVel: "vel11"
                    }
                }
                Rectangle {
                    height: parent.height/2
                    width: parent.width
                    //border.color: "red"
                    color: "transparent"
                    VelCircle { anchors.centerIn: parent; property string idVel: "vel12" }
                }
            }

        }
    }
}
