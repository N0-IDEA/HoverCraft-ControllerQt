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

    property int externalRows: getTotalRows(gridMain)
    readonly property string idGrid: "gridMain"

    Material.accent: Material.color(Material.DeepOrange);
    Material.theme: Material.Dark;
    Material.foreground: "#FFFFFF"
    //Material.primary: "#FFFFFF"
    color: "black"
    onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)


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
            property int cols: 4
            Layout.minimumWidth: parent.width / 12 * cols
            Layout.minimumHeight: parent.height
            Layout.columnSpan: cols
            Layout.rowSpan: 10


            MainComponents.GridBase {
                id: gridRepeater
                rows: getTotalRows(gridRepeater)
                Rectangle{
                    focus: true
                    color: "transparent"
                    border.color: "white"
                    property int cols: 12
                    height: parent.height /externalRows
                    Layout.preferredWidth: parent.width / 12 * cols
                    Layout.preferredHeight: parent.height / gridRepeater.rows
                    Layout.columnSpan: cols
                    Label {
                        text: "Opciones"
                        width: parent.width
                        font.pixelSize:  20
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                ButtonOption{
                    id: buttons
                    property int repeaterRows: gridRepeater.rows
                }
                Rectangle{
                    color: "transparent"
                    border.color: "white"
                    property int cols: 12
                    height: parent.height /externalRows
                    Layout.preferredWidth: parent.width / 12 * cols
                    Layout.preferredHeight: parent.height / gridRepeater.rows
                    Layout.columnSpan: cols

                    Label {
                        font.pixelSize:  20
                        text: "Atras"
                        width: parent.width
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
        Rectangle{
            property int cols: 8
            Layout.minimumWidth: parent.width / 12 * cols
            Layout.minimumHeight: parent.height / externalRows
            Layout.columnSpan: cols
           // border.color: "red"
            color: "transparent"
            ConfigButtonsCanvas{
                id: canvas
            }
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
