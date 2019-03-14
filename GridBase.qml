import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12


GridLayout {
    property int initialColumns: 12
    property int initialRows: externalRows
    columnSpacing: 0
    rowSpacing: 0
    property string  id: idGrid
    rows: externalRows
    columns: initialColumns
    height: parent.height
    anchors.fill: parent
    flow:  width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom
 /*   function getRows () {
        return width < height ? initialColumns : contentItem.children / initialColumns
    }*/


}







