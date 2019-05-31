import QtQuick 2.0

import QtQuick.Controls 2.12

Popup {
    id: popup
    width: 400
    height: 200
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    anchors.centerIn: parent//coment for design

    Text {
        id: element
        color: "white"
        text: qsTr("¿Estas seguro de que quieres borrarlo?")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 30
        font.pixelSize: 16
    }
    Row {
        id: row
        y:parent.height*7/10
        height: parent.height*3/10
        width: button.width + button1.width + parent.width*2/10
        anchors.horizontalCenter: parent.horizontalCenter
        Button {
            id: button
            anchors.left: parent.left
            focusPolicy: Qt.ClickFocus
            highlighted: true
            flat: true
            //Icon made by [https://www.flaticon.com/authors/hanan] from www.flaticon.com
            icon.source:  "../media/checked.png"
            ToolTip.visible: hovered
            ToolTip.delay: 1000
            ToolTip.text: qsTr("Aceptar")
            onClicked: {
                configWindow.deleteProfileSignal()
                refreshSelectedProfile();
                popup.close()
            }
        }

        Button {
            id: button1
            anchors.right: parent.right
            flat: true
            highlighted: true
            //Icon made by [https://www.flaticon.com/authors/gregor-cresnar] from www.flaticon.com
            icon.source:  "../media/close.png"
            ToolTip.visible: hovered
            ToolTip.delay: 1000
            ToolTip.text: qsTr("Cancelar")
            onClicked: {popup.close()}
        }
    }
}
