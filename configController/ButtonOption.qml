import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

Repeater {
    model: options
    property string type: "repeater"
    property int interFontSize: fontsize
    objectName: "buttonsRepeater"
    delegate: Rectangle {
        property int cols: 12
        Layout.minimumWidth: parent.width / 12 * cols
        Layout.minimumHeight: (parent.height / repeaterRows) + (theOption.height/3.5)
        Layout.columnSpan: cols
        border.color: "white"
        color: "transparent"
        ColumnLayout{
            Label {
                id: theOption
                font.pixelSize:  interFontSize
                color: Material.color(Material.DeepOrange)
                Layout.minimumHeight: parent.parent.height/2
                Layout.minimumWidth: parent.parent.width
                text: modelData.option
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                font.pixelSize:  interFontSize
                Layout.minimumHeight: parent.parent.height/2
                Layout.minimumWidth: parent.parent.width
                text: /*"Mando %1:*/"Botón %2" /*.arg(modelData.idGamepad)*/.arg(modelData.idButton);
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
