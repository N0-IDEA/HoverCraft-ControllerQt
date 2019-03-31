import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../" as MainComponents
import "../menu/" as MenuComponents

ApplicationWindow {
    id: configWindow
    objectName: "configWindow"
    width: 1280
    height: 960
    minimumWidth: 1280
    minimumHeight: 960
    visible: true
    title: "Configurar Mando"

    property variant options;
    property variant axisOptions;
    property variant buttonOptions;
    property int count;

    property int externalRows: getTotalRows(gridMain)
    readonly property string idGrid: "gridMain"

    Material.accent: Material.color(Material.DeepOrange);
    Material.theme: Material.Dark;
    Material.foreground: "#FFFFFF"
    color: "black"
    onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)
    MainComponents.GridBase{
        Rectangle{
            color: "transparent"
            property int cols: 12
            width: parent.width / 12 * cols
            height: parent.height / externalRows
            Layout.columnSpan: cols

            Row {
                spacing: 10
                ComboBox {
                    width: 120
                    model: [ "Perfil 1", "Perfil 2", "Perfil 3" ]
                }
                Button {
                    Material.background: "transparent"
                    icon.color: Material.color(Material.DeepOrange)
                    icon.name: "list-add"
                    onClicked: {
                        addProfile.visible = true;
                    }
                }
                Button {
                    Material.background: "transparent"
                    icon.color: "grey"
                    icon.name: "user-trash"
                }
            }
            TabBar {
                id: tabBar
                currentIndex: swipeView.currentIndex
                width: 500
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater{
                    model: configWindow.count
                    TabButton {
                        width: 300
                        text: "Mando %1:" .arg(index);
                    }
                }
            }
        }
        Page {
            id: page
            SwipeView {
                id: controllerOptions;
                currentIndex: tabBar.currentIndex
                Repeater{
                    model: configWindow.count
                    MenuComponents.BaseController {
                        width: configWindow.width;
                        height:configWindow.height - tabBar.height;
                        y: tabBar.height
                    }
                }
            }}
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

    DialogNewProf {id: addProfile}

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

    function configButton(idButton, msg) {
        dialogConfig.visible = true;
        dialogConfig.text = msg;
        configWindow.configButtonSignal(idButton);
    }

    onConfigDone:{
        bindDone();
    }

    function bindDone() {
        dialogConfig.visible = false;
        var object = controllerOptions.children[0].children[0];
        for(var i = 0; i < object.children.length; ++i)
            for(var j = 0; j < object.children[i].children.length; ++j){
                object.children[i].children[j].children[1].children[0].requestPaint();
            }
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
