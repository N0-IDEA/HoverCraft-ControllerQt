import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Item {
    property int ppm: 0
    property alias speedometerWidth: speedometer.width
    property alias speedometerHeight: speedometer.height
    antialiasing: true
    rotation: 0
    scale: 1
    CircularGauge {
        id: speedometer
        width: 250
        height: 250
        antialiasing: true
        value: ppm
        anchors.verticalCenter: parent.verticalCenter
        maximumValue: 255
        style: HoverGaugeStyle {}
    }
}



























/*##^## Designer {
    D{i:0;autoSize:true;height:250;width:250}
}
 ##^##*/
