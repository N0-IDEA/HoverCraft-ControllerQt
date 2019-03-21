import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: mainWindow
    width: 900
    height: 600
    visible: true

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Menu {}
    }
}
