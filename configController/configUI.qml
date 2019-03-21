import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../" as MainComponents
import "../menu/" as MenuComponents

ApplicationWindow {
    id: configWindow
    width: 900
    height: 600
    visible: true
    title: "Configurar Mando"

    property variant options;
    property variant axisOptions;
    property variant buttonOptions;

    property int externalRows: getTotalRows(gridMain)
    readonly property string idGrid: "gridMain"

    Material.accent: Material.color(Material.DeepOrange);
    Material.theme: Material.Dark;
    Material.foreground: "#FFFFFF"
    color: "black"
    onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)
    TabBar {
        anchors.horizontalCenter: parent.horizontalCenter
        TabButton {
            width: 300
            text: qsTr("Controller 1")
        }
        TabButton {
            width: 300
            text: qsTr("Controller 2")
        }
        TabButton {
            width: 300
            text: qsTr("Controller 3")
        }
    }
    //MenuComponents.BaseController{}

    Dialog {
        id: dialogConfig
        property string text: "#####"
        width: 250
        height: 250
        z: 1
        modal: true
        visible: false
        anchors.centerIn: parent
        closePolicy: Popup.NoAutoClose;
        Text {
            color: "white"
            text: dialogConfig.text;
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }

    function findOption(idGamepad, idButton) {
        for(var i = 0; i < buttonOptions.length; i++) {
            var option = buttonOptions[i];
            if(idGamepad == option.idGamepad && idButton == option.idButton)
                return option;
        }
        return null;
    }

    function findOptionAxis(idGamepad, idButton, value) {
        for(var i = 0; i < axisOptions.length; i++) {
            var option = axisOptions[i];
            if(idGamepad == option.idGamepad && idButton == option.idButton && (Math.abs(option.value - value) <= 0.001))
                return option;
        }
        return null;
    }

    /*   Connections {
        target: button
        onClicked: console.log(axisOptions)
    }
*/

    signal configButtonSignal(int id);
    signal configDone();

    onConfigDone:{
        bindDone();
    }

    function configButton(idButton, msg) {
        dialogConfig.visible = true;
        dialogConfig.text = msg;
        window.configButtonSignal(idButton);
    }

    function bindDone() {
        dialogConfig.visible = false;
        canvas.requestPaint();
    }
    function getTotalRows(gridMain){
        var totalCols = 0;
        for(var i = 0; i < gridMain.children.length; ++i)
            if(gridMain.children[i].type === "repeater")
                for(var j = 0; j < gridMain.children[i].count; ++j)
                    totalCols += gridMain.children[i].itemAt(j).cols
            else
                totalCols += gridMain.children[i].cols;
        console.log("columnas totales: "+totalCols/12)
        return totalCols/12
    }
}
