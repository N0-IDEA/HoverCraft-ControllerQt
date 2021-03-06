import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../" as MainComponents
import "../configController/" as ConfigComponents
Rectangle {
    color: "transparent"
    MainComponents.GridBase {
        id: gridMain
        anchors.top: window.top
        anchors.left: window.left
        anchors.right: window.right
        anchors.bottom: window.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        Rectangle{
            color:"transparent"
            // border.color: "green"
            property int cols: 3
            Layout.minimumWidth: parent.width / 12 * cols
            Layout.minimumHeight: parent.height
            Layout.columnSpan: cols
            Layout.rowSpan: 10

            MainComponents.GridBase {
                id: gridRepeater
                rows: getTotalRows(gridRepeater)
                //rowSpacing: 20
                Rectangle{
                    focus: true
                    color: "transparent"
                    border.color: "white"
                    property int cols: 12
                    height: parent.height / gridRepeater.rows
                    Layout.preferredWidth: parent.width / 12 * cols
                    Layout.preferredHeight: {
                        console.log( gridRepeater.rows)
                    return    parent.height / gridRepeater.rows
                    }
                    Layout.columnSpan: cols
                    Label {
                        text: "Opciones"
                        anchors.fill: parent
                        font.pixelSize:  parent.height *0.6
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                ConfigComponents.ButtonOption{
                    id: buttons
                    property int repeaterRows: gridRepeater.rows
                }

                Rectangle{
                    color: "transparent"
                    border.color: "white"
                    property int cols: 12
                    height: parent.height /gridRepeater.rows
                    Layout.preferredWidth: parent.width / 12 * cols
                    Layout.preferredHeight: parent.height / gridRepeater.rows
                    Layout.columnSpan: cols
                    Label {
                        font.pixelSize:  parent.height *0.6
                        text: "Atras"
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        MouseArea{
                            anchors.fill: parent;
                            onClicked: {
                                lp.source=""
                                window.show()
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            objectName: "canvasOptions"
            property int cols: 9
            Layout.minimumWidth: parent.width / 12 * cols
            Layout.minimumHeight: parent.height
            Layout.columnSpan: cols
            //border.color: "red"
            color: "transparent"
            ConfigComponents.ConfigButtonsCanvas{
               id: canvasOptionRender
               z: 1
            }
            Image {
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectFit
                source: "/configController/mando.png"
                z: 0
            }
        }
    }
}
