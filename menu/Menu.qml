import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../" as MainComponents
import QtGraphicalEffects 1.12


ApplicationWindow {
    id: window
    title: "Configurar Mando"
    visible: true
    //visibility: "FullScreen"
    width: 900
    height: 600
    Material.accent: Material.color(Material.DeepOrange);
    Material.theme: Material.Dark;
    Material.foreground: "#FFFFFF"
    //Material.primary: "#FFFFFF"
    color: "black"
    property int externalRows: getTotalRows(gridMain)
    readonly property string idGrid: "gridMain"
    signal initConfig();
    signal initMain();
   // CanvasTest{ z: 10}
   /* Rectangle {
        z: 15
        id: txt2
        //y: window.height * 0.1
        width: window.width
        height: window.height /// 5
        color: "transparent"
        Behavior on color {
            SequentialAnimation {
                loops: 1
                ColorAnimation { from: "transparent"; to: "#FFC2BF"; duration: 150 }
                ColorAnimation { from: "#FFC2BF"; to: "transparent";  duration: 150 }
            }
        }
    }*/
   // CanvasMenu { z: 20}

     CanvasLight{ z: 28 }
    /* layer.enabled: true
         layer.effect: Glow {
             samples: 10
             radius: 4
             //spread:  8
             color: Material.color(Material.DeepOrange)
             transparentBorder: false
         }*/

   // CanvasCloudsTop { z: 29 }

    MainComponents.GridBase {
        id: gridMain
        z: 30
        anchors.top: window.top
        anchors.left: window.left
        anchors.right: window.right
        anchors.bottom: window.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        Rectangle{
            id: titleMenuRec
            property int cols: 12
            Layout.minimumWidth: parent.width / 12 * cols
            Layout.minimumHeight: parent.height *5/10
            Layout.columnSpan: cols
            //border.color: "red"
            color: "transparent"
            /*  Rectangle {
                       id: transparentBorderRect
                       x: titleMenu.x
                       y: titleMenu.y + titleMenu.height /2
                       width: titleMenu.width
                       height: 1
                       color: "black"
                       radius: 10
                       layer.enabled: true
                       layer.effect: Glow {
                           samples: 17
                           radius: 50
                           //spread: 8
                           color: Material.color(Material.DeepOrange)
                           transparentBorder: true
                       }
                   }*/
            MainComponents.GlowingLabel {
                id: titleMenu
                property color colorGlow:  Material.color(Material.DeepOrange);
                text: qsTr(String("HOVERCRAFT")) ;
                color:"white"
                anchors.centerIn: parent
                font.pixelSize:  50
                font.family: "starcraft"
            }
        }
        Rectangle {
            color:"transparent"
            // border.color: "green"
            property int cols: 4
            Layout.minimumWidth: parent.width / 12 * cols
            Layout.minimumHeight: parent.height*5/10
            Layout.columnSpan: cols
            Layout.rowSpan: 6
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            MainComponents.GridBase {
                id: gridRepeater
                rows: getTotalRows(gridRepeater)
                rowSpacing: 30
                //LabelTesting{}
                LabelRectangle {
                    id: conducir
                    property string text: "Conducir"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            gridRepeater.moveTo("../Main.qml",window,false)
                            window.initMain();
                        }
                    }
                    Loader{ id:ld; anchors.fill: parent; }
                }
                LabelRectangle {
                    property string text: "Opciones"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            gridRepeater.moveTo("../configController/configUI.qml",window,false)
                            window.initConfig();
                        }
                    }
                    Loader{ id:lp; anchors.fill: parent; objectName: "lp" }
                }
                LabelRectangle {
                    property string text: "Salir"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            window.close();
                        }
                    }
                }
                function moveTo(elementPath,window, value){
                    lp.source=elementPath
                    value ? window.show() : window.hide()
                }
            }
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
        // console.log("columnas totales: "+totalCols/12)
        return totalCols/12
    }
}
