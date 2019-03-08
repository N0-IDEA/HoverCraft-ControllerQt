import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

CircularGauge {
    property int ppm: 0
    //property var model;
    id: speedometer
    antialiasing: true
    value: ppm
    maximumValue: 1800
    minimumValue: 1000

    style: MotorGaugeStyle {}
}


































/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
