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
    modal: true
    visible: false
    anchors.centerIn: parent
    closePolicy: Popup.NoAutoClose;
    Column {
        id: column
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
            anchors.verticalCenter: parent.verticalCenter
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
                text: qsTr("")
                placeholderText: "Perfil"
                anchors.rightMargin: -200
                anchors.right: parent.left
            }
        }
    }

    Button {
        id: button

        focusPolicy: Qt.ClickFocus
        checkable: false
        autoRepeat: false
        highlighted: true
        flat: true
        anchors.rightMargin: button1.width + 10
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        spacing: -3
        //Icon made by [https://www.flaticon.com/authors/maxim-basinski] from www.flaticon.com
        icon.source:  "../media/checked.png"
        ToolTip.visible: hovered
        ToolTip.delay: 1000
        ToolTip.text: qsTr("Crear un nuevo perfil")
        onClicked: {
            dialog.visible = false;
            configWindow.createProfileSignal(textField.text);
            refreshSelectedProfile();
        }
    }

    Button {
        id: button1
        flat: true
        highlighted: true
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        //Icon made by [https://www.flaticon.com/authors/freepik] from www.flaticon.com
        icon.source:  "../media/delete.png"
        ToolTip.visible: hovered
        ToolTip.delay: 1000
        ToolTip.text: qsTr("Cancelar")
        onClicked: {
            dialog.visible = false;
        }
    }


}


