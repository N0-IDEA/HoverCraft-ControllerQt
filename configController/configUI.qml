import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../" as MainComponents

ApplicationWindow {
    id: window
    width: 900
    height: 600
    visible: true
    title: "Configurar Mando"

    property variant options;
    property variant axisOptions;
    property variant buttonOptions;

    property int externalRows: getTotalRows()
    readonly property string idGrid: "gridMain"

    Material.accent: Material.color(Material.DeepOrange);
    Material.theme: Material.Dark;
    Material.foreground: "#FFFFFF"
    //Material.primary: "#000000"


    MainComponents.GridBase {
        id: gridMain
        Layout.preferredWidth:  parent.width / 2
        Layout.preferredHeight:  parent.height
       // flow: GridLayout.TopToBottom
        Repeater {
            model: options
            id: buttons
            property string type: "repeater"
            objectName: "buttonsRepeater"
            delegate: Rectangle{
                property int cols: 3
                property int initWidth: parent.width / 12 * cols
                property int initHeight: parent.height / externalRows
                Layout.columnSpan: cols
             /*   RowLayout {
                    width: parent.width
                    height: parent.height
*/
                    Label {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: modelData.option;
                        verticalAlignment: Text.AlignVCenter
                    }
/*
                    Label {
                     //   Layout.fillWidth: true
                     //   Layout.fillHeight: true
                        text: "Mando %1: %2".arg(modelData.idGamepad).arg(modelData.idButton);
                        verticalAlignment: Text.AlignVCenter
                    }*/

         /*           Button {
                        highlighted: true;
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: "Cambiar";
                        onClicked: configButton(index, modelData.configMsg);
                    }*/
                }
            }
  //      }
        ConfigButtonsCanvas{
            id: canvas
            property int cols: 9
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }
    }
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
    function getTotalRows(){
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
