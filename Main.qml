import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4
import "menu/" as MenuComponents


ApplicationWindow {
    id: root
    objectName: "mainWindow"
    visible: true
    width: 1080
    height: 720
    title: "HoverUI"
    property variant motorsModel;
    property variant servosModel;
    readonly property string idGrid: "gridMain"
    property int externalRows: getTotalRows()
    color: "black"//"#0F1B23"

    GridBase {
        id: gridMain
        Repeater {
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
        }
        Repeater {
            model: servosModel
            id: servos1
            property string type: "repeater"
            objectName: "buttonsRepeater2"
            delegate: Servo {
                property string name: "Servo 1"
                property int ppmValue: modelData.value
                //property int ppmDelayed: modelData.valueDelayed
                property int cols: 6
                property int initWidth: parent.width / 12 * cols
                property int initHeight: parent.height / externalRows
                Layout.columnSpan: cols
            }
        }

        BaterryCanvas {
            property string name: "Servo 2"
            property int levelBaterry: 16
            property int cols: 6
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }
        BaterryCanvas {
            property string name: "Servo 2"
            property int levelBaterry: 52
            property int cols: 6
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }
        BaterryCanvas {
            property string name: "Servo 2"
            property int levelBaterry: 2
            property int cols: 6
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }
        BaterryCanvas {
            property string name: "Servo 2"
            property int levelBaterry: 100
            property int cols: 6
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }
        MenuComponents.LabelRectangle {
            property string text: "Salir"
            property int cols: 6
            Layout.preferredWidth: parent.width / 12 * cols
            Layout.preferredHeight: parent.height /externalRows
            Layout.columnSpan: cols
            MouseArea{
                anchors.fill: parent;
                 onClicked: {
                     lp.source=""
                     window.show()
                 }
            }
        }
    }
    function getTotalRows(){
        var totalCols = 0;
        for(var i = 0; i < gridMain.children.length; ++i)
            if(gridMain.children[i].type === "repeater")
                for(var j = 0; j < gridMain.children[i].count; ++j)
                    totalCols += gridMain.children[i].itemAt(j).cols
            else
                totalCols += gridMain.children[i].cols;
        //console.log("columnas totales: "+totalCols/12)
        return totalCols/12
    }
}
