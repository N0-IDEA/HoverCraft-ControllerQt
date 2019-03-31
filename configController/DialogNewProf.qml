import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

Dialog {
    id: dialog
    property string text: "Agrega un perfil"
    width: 400
    height: 250
    z: 1
    modal: true
    visible: true
    anchors.centerIn: parent
    closePolicy: Popup.NoAutoClose;
    Column {
        anchors.fill: parent
        Text {
            id: text1
            color: "white"
            text: qsTr("Agrega un nuevo perfil")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 18
        }
        Rectangle {
            id: rectangle
            width: textField.width + label.width
            height: textField.height
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                id: label
                text: qsTr("Nombre:")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                renderType: Text.NativeRendering
            }

            TextField {
                id: textField
                text: qsTr("Text Field")
                anchors.rightMargin: -200
                anchors.right: parent.left
            }
        }
    }

    Button {
        id: button
        anchors.rightMargin: button1.width + 10
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        spacing: 0
        icon.name: "folder-new"
        onClicked: {dialog.visible = false;}
    }

    Button {
        id: button1
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        icon.name: "edit-delete"
        onClicked: {dialog.visible = false;}
    }


}


