import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    id: root
    visible: true
    width: 1080
    height: 720
    title: "HoverUI"
    readonly property string idGrid: "gridMain"
    property variant motorsModel : ({value: 0});
    property int externalRows: getTotalRows()
    color: "black"//"#0F1B23"

    GridBase {
        id: gridMain
        Layout.preferredWidth:  parent.width / 2
        Layout.preferredHeight:  parent.height
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
        Servo {
            property string name: "Servo 1"
            property int cols: 6
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }
        Servo {
            property string name: "Servo 2"
            property int cols: 6
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
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

        Motor {
            property string nameMotor: "Motor 2"
            property string ppmValue: "100"
            property int ppmDelayed: 100
            property int cols: 6
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }
        Motor {
            property string nameMotor: "Motor 3"
            property string ppmValue: "100"
            property int ppmDelayed: 100
            property int cols: 6
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
        }
        Motor {
            property string nameMotor: "Motor 4"
            property string ppmValue: "100"
            property int ppmDelayed: 100
            property int cols: 6
            property int initWidth: parent.width / 12 * cols
            property int initHeight: parent.height / externalRows
            Layout.columnSpan: cols
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
        console.log("columnas totales: "+totalCols/12)
        return totalCols/12
    }
}
