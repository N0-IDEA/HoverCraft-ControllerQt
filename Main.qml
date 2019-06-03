import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4
import HoverCameraPK 1.0
import "menu/" as MenuComponents


ApplicationWindow {
    id: root
    objectName: "mainWindow"
    visible: true
    width: 1200
    height: width/2
    title: "HoverUI"
    property variant motorsModel;
    property variant servosModel;
    readonly property string idGrid: "gridMain"
    property int anyRows: getTotalRows(gridMain)
    property int externalRows: anyRows - 1
    property color colorGlow: Material.color(Material.DeepOrange)
    color: "black"
    GridBase {
        id: gridMain
        Motor {
            property string nameMotor: "X"
            property string ppmValue: motorsModel[0].value
            property int ppmDelayed: motorsModel[0].valueDelayed
            property int cols: 3
            property int rows: 0
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }
        Rectangle {
            property string text: "Salir"
            property string colorLabel: "white"
            property int cols: 9
            property int rows: 4
            Layout.preferredWidth: parent.width / 12 * cols
            Layout.preferredHeight: {
                var oper = (anyRows  )
                console.log("external Rows: " +anyRows)
                console.log("Rows: " +rows)
                console.log("Fixed rows: " +oper)

                if(rows > 0){
                    return parent.height / 1
                }
                else
                    return parent.height /anyRows

            }
            Layout.columnSpan: cols
            Layout.rowSpan: rows
            border.color: "red"
            HoverCamera { //Mantener relacion aspecto
                mirrorVertically: true;
                property int initWidth: parent.width
                property int initHeight: parent.height
                width: initHeight*1.5 === initWidth ? initWidth : initHeight*1.5;
                height: initHeight;
            }
        }
        Motor {
            property string nameMotor: "Y"
            property string ppmValue: motorsModel[1].value
            property int ppmDelayed: motorsModel[1].valueDelayed
            property int cols: 3
            property int rows: 0
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }

        Rectangle {
            id: recGridBaterry
            property int cols: 3
            property int rows: 0
            Layout.preferredWidth: parent.width / 12 * cols
            Layout.preferredHeight: parent.height /externalRows
            Layout.columnSpan: cols
            color: "transparent"
            //border.color: "red"
            property int batteryRows: {
                var theRows = getTotalRows(gridBattery)
                // console.log("Rows: "+theRows )
                return theRows
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    lp.source=""
                    window.show()
                }
            }
            GridBase {
                id: gridBattery
                Repeater {
                    model: servosModel
                    id: servos2
                    property string type: "repeater"
                    objectName: "buttonsRepeater2"
                    delegate: Servo {
                        Layout.topMargin: parent.height*0.1
                        Layout.bottomMargin: parent.height*0.1
                        property string name: "Timón"
                        property int ppmValue: modelData.value
                        property int cols: 12
                        property int rows: 0
                        property int initWidth: parent.width / 12 * cols
                        property int initHeight: parent.height / 6
                        Layout.columnSpan: cols
                        //border.color: "red"
                    }
                }
                Rectangle {
                    property string text: ""
                    color: "transparent"
                    property int cols: 12
                    property int rows: 0
                    property int initWidth: parent.width / 12 * cols
                    property int initHeight: parent.height /6
                    Layout.preferredWidth: initWidth
                    Layout.preferredHeight: initHeight
                    Layout.columnSpan: cols
                    Row {
                        id: rowServo
                        anchors.fill: parent
                        spacing: (parent.width - servoName.width) *0.01
                        leftPadding: (parent.width - servoName.width) *0.05
                        GlowingLabel { id: servoName; text: "Celdas"; anchors.verticalCenter: parent.verticalCenter; color: "white"; font.pixelSize:  24 }
                    }
                }
                BaterryCanvas {
                    objectName: "cell1"
                    property string name: ""
                    property int levelBaterry: 16
                    property int cols: 12
                    property int rows: 0
                    property int initWidth: parent.width/ 12 * cols
                    property int initHeight: parent.height / 6
                    Layout.columnSpan: cols
                }
                BaterryCanvas {
                    objectName: "cell2"
                    property string name: ""
                    property int levelBaterry: 52
                    property int cols: 12
                    property int rows: 0
                    property int initWidth: parent.width / 12 * cols
                    property int initHeight: parent.height / 6
                    Layout.columnSpan: cols
                }
                BaterryCanvas {
                    objectName: "cell3"
                    property string name: ""
                    property int levelBaterry: 2
                    property int cols: 12
                    property int rows: 0
                    property int initWidth: parent.width / 12 * cols
                    property int initHeight: parent.height / 6
                    Layout.columnSpan: cols
                }
            }
        }

    }

    function getTotalRows(gridMain){
        var totalCols = 0;
        for(var i = 0; i < gridMain.children.length; ++i)
            if(gridMain.children[i].type === "repeater")
                for(var j = 0; j < gridMain.children[i].count; ++j)
                    if(gridMain.children[i].itemAt(j).rows > 0)
                        totalCols += (gridMain.children[i].itemAt(j).rows - 1) * 12
                    else
                        totalCols += gridMain.children[i].itemAt(j).cols

            else
                if(gridMain.children[i].rows > 0)
                    totalCols += (gridMain.children[i].rows - 1) * 12
                else
                    totalCols += gridMain.children[i].cols;
        //console.log("columnas totales: "+totalCols/12)
        return Math.ceil (totalCols/12)
    }
}


/*Repeater {
    model: motorsModel
    id: motor1
    property string type: "repeater"
    objectName: "buttonsRepeater"
    delegate: Motor {
    property string nameMotor: "Motor 1"
    property string ppmValue: modelData.value
    property int ppmDelayed: modelData.valueDelayed
    property int cols: 6
    property int initWidth: parent.width / 12 * cols
    property int initHeight: parent.height / externalRows
    Layout.columnSpan: cols
    }
}*/
