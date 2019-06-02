import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

Repeater {
    model: options
    property string type: "repeater"
    objectName: "buttonsRepeater"
    delegate: Rectangle {
        id: recOptions1
        property int cols: 12
        Layout.minimumWidth: parent.width / 12 * cols
        Layout.minimumHeight: parent.height / repeaterRows
        Layout.columnSpan: cols
        border.color: "white"
        color: "transparent"
        ColumnLayout{
            Label {
                id: theOption
                font.pixelSize:  parent.height*0.6
                color: Material.color(Material.DeepOrange)
                Layout.minimumHeight: recOptions1.height
                Layout.minimumWidth: recOptions1.width
                text: modelData.option
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }            
        }
        MouseArea{
            anchors.fill: parent
            onClicked: configButton(index, modelData.configMsg);
        }
    }
}
