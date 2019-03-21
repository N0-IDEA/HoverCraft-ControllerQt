import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../" as MainComponents

Rectangle{
    property string labelText: text
    color: "transparent"
    border.color: "white"
    property int cols: 12
    height: parent.height /externalRows
    Layout.preferredWidth: parent.width / 12 * cols
    Layout.preferredHeight: parent.height / gridRepeater.rows
    Layout.columnSpan: cols

    Label {
        font.pixelSize:  20
        text: labelText
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
