import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: window
    width: 600
    height: 600
    visible: true
    title: "Prueba"

    property variant myModel;

    Material.accent: Material.color(Material.DeepOrange);
    Material.theme: Material.Dark;
    Material.foreground: "#FFFFFF"
    //Material.primary: "#000000"

    Dialog {
        id: dialogConfig
        width: 250
        height: 250
        //title: qsTr("Configurando Boton")
        z: 1
        modal: true
        visible: false
        anchors.centerIn: parent

        closePolicy: Popup.NoAutoClose;

        /*contentItem: Rectangle {
            //implicitWidth: 200
            //implicitHeight: 200
            */
        Text {
            text: qsTr("Pulse cualquier boton")
            font.pixelSize: 20
            anchors.centerIn: parent
        }
        //}
    }

    GroupBox {

        title: qsTr ("Options")

        GridLayout {
            rows: 6
            rowSpacing: 5
            columnSpacing: 5
            Layout.fillWidth: true
            Layout.fillHeight: true
            flow: GridLayout.TopToBottom

            Repeater {
                model: myModel
                id: buttons
                objectName: "buttonsRepeater"
                delegate: RowLayout {
                    width: parent.width
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Label {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: modelData.option;
                        verticalAlignment: Text.AlignVCenter
                    }

                    Label {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: "Mando %1: %2".arg(modelData.idGamepad).arg(modelData.idButton);
                        verticalAlignment: Text.AlignVCenter
                    }

                    Button {
                        highlighted: true;
                        Layout.fillHeight: true
                        Layout.maximumWidth: 100;
                        //Layout.preferredWidth: 200
                        text: "Cambiar";
                        onClicked: configButton(index);
                    }
                }
            }
        }
    }

    Button {
        id: button
        x: 72
        y: 480
        text: qsTr("Button")
    }

    Connections {
        target: button
        onClicked: console.log(buttons.model)
    }

    signal configButtonSignal(int id);
    signal configDone();

    onConfigDone:{
        bindDone();
    }

    function configButton(idButton) {
        dialogConfig.visible = true;
        window.configButtonSignal(idButton);
    }

    function bindDone() {
        dialogConfig.visible = false;
    }
}

























