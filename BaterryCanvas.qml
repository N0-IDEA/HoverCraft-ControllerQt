import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4

Rectangle{
    property int initialWidth: initWidth
    property int initialHeight: initHeight
    property int batteryLevel: levelBaterry
    property color colorGlow: Material.color(Material.DeepOrange)
    readonly property string labelName: name
    Layout.preferredHeight: initialHeight
    Layout.preferredWidth:  initialWidth
    color:"transparent"
    //border.color: "red"
    Row {
        id: rowServo
        anchors.fill: parent
        spacing: (initialWidth - servoName.width) *0.01
        leftPadding: (initialWidth - servoName.width) *0.05
        GlowingLabel { id: servoName; text: labelName; anchors.verticalCenter: parent.verticalCenter; color: "white"; font.pixelSize:  24 }
        Column {
            id: column
            width: (initialWidth - servoName.width)
            height: initialHeight
            anchors.verticalCenter: parent.verticalCenter;
            Canvas {
                id: mycanvas
                width: (initialWidth - servoName.width - rowServo.spacing - rowServo.leftPadding)*0.95
                height: initialHeight
                smooth: true
                onPaint: {//TODO contador de vueltas osea barras para asociar al porcentaje
                    var ctx     = getContext("2d")
                    var onePor = 55/100
                    var widthBar = mycanvas.width*0.75 / 55
                    var heightBar = parent.height /2
                    var initXY = [0, heightBar/2]
                    var xC = initXY[0]
                    var level = batteryLevel * onePor

                    for (var i = 1; i <= level; i++) {
                        xC += widthBar *1.4
                        if (i % 11 === 0 )
                            xC -= Math.floor(widthBar)
                        else{
                            ctx.fillStyle = setLevelColor (onePor, level)
                            ctx.fillRect(xC, initXY[1], widthBar, heightBar)
                        }
                    }
                }
                function setLevelColor (onePorcent,levelBaterry) {
                    return 15* onePorcent >= levelBaterry ? "red"
                         : 50* onePorcent >= levelBaterry ? Material.color(Material.DeepOrange)
                         : "#212121" }//"#006fbf" }
            }

        }
    }
}















/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

