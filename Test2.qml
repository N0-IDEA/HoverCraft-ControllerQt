import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: window
    property int sizemin: 150
    property int sizemax: 300
    property int sizenormal: 300
    property int spacing: 5

    property variant motorsModel;

    /*maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width*/

    minimumHeight: sizemin * 2 + spacing;
    minimumWidth: sizemin * 2 + spacing;

    maximumHeight: sizemax * 2 + spacing;
    maximumWidth: sizemax * 2 + spacing;

    visible: true
    title: "Hover TEST"

    color: "#b3000000"

    Material.accent: Material.color(Material.DeepOrange);
    Material.theme: Material.Dark;
    Material.foreground: "#FFFFFF"

    GridLayout {
        id : grid
        flow: GridLayout.LeftToRight
        layoutDirection: Qt.LeftToRight
        anchors.fill: parent
        rows    : 2
        columns : 2
        rowSpacing: spacing
        columnSpacing: spacing

        Repeater {
            model: motorsModel
            id: buttons
            objectName: "buttonsRepeater"
            delegate: Motor {
                ppm: modelData.value
                Layout.preferredHeight: sizenormal
                Layout.preferredWidth: sizenormal
                Layout.maximumHeight: sizemax
                Layout.maximumWidth: sizemax
                Layout.minimumHeight: sizemin
                Layout.minimumWidth: sizemin
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.columnSpan: 1
                Layout.rowSpan: 1
            }
        }

    }



}

























































/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
