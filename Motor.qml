import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12



Rectangle {
    readonly property color colorLightGrey: "#888"
    readonly property color colorDarkGrey: "#333"
    readonly property color colorGlow: Material.color(Material.DeepOrange)//"#7CC1CC"
    readonly property string gridMain: idGrid
    readonly property string ppm: ppmValue
    readonly property int ppmVel: ppmDelayed
    readonly property int max: 900
    readonly property string name: nameMotor
    id: recMayor
    property int initialWidth: initWidth
    property int initialHeight: initHeight
    Layout.preferredHeight: initialHeight
    Layout.preferredWidth:initialWidth
    // border.color: parent.width > parent.height? "green" : "orange"
    // border.width: 1
    color: "transparent"
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        // onClicked: function () { console.log(alguno.width)} //parent.state = "PRESSED"; parent.visible = false;}
    }
    states: [ State { name: "moved"; when: mouseArea.pressed; PropertyChanges { target: recMayor; x: 50; y: 50 } } ]
    /* transitions: [
        Transition {
            NumberAnimation { properties: "x,y"; duration: 1000 }
        }
    ]*/

    function getDurationVel(initialDuration, maxPPM,ppmVel) {
           var milis =  Math.floor(initialDuration/100 * getPorcent(maxPPM,ppmVel))
           return  (milis < 71) ? 71 : milis
       }
    function getPorcent(maxPPM, ppmVel) {
        var onePorcentPPM = maxPPM/100
        var currentPorcent = !((ppmVel - 1000) / onePorcentPPM)? 1 : ((ppmVel - 1000) / onePorcentPPM)
        return (100 - currentPorcent)
    }
    onPpmVelChanged:{
        animationVel1.duration = getDurationVel(2500,max, ppmVel);
        velCircle1.porcent = Math.ceil(((ppm-1000)/max)*100);
        velCircle1.requestPaint();
    }
    GridBase{
        id: grid
        Rectangle {
            Layout.minimumWidth:  Math.floor(parent.width / 10)*3
            Layout.minimumHeight:  parent.height
            // border.color: "red"
            color: "transparent"
            Column {
                width:  parent.width
                height:   parent.height /2
                Rectangle{
                    height: parent.parent.height/2
                    width: parent.parent.width
                    // border.color: "red"
                    color: "transparent"
                    GlowingLabel { anchors.centerIn: parent; text: qsTr(String(Math.ceil(((ppmVel-1000)/max)*100))) ; color: "white"; font.pixelSize:  24 }//name;
                }
                Rectangle{
                    height: parent.parent.height/2
                    width: parent.parent.width
                    // border.color: "red"
                    color: "transparent"
                    GlowingLabel { anchors.centerIn: parent; text: qsTr(String(ppm)); color: "white"; font.pixelSize: 24; }
                }
            }
        }
        Rectangle {
            Layout.minimumWidth:  Math.floor(parent.width / 10)*5
            Layout.minimumHeight:  parent.height
            color: "transparent"
            // border.color: "red"
            EngineCanvas {
                Layout.minimumWidth:  Math.floor(parent.parent.width / 10)*5
                Layout.minimumHeight:  parent.parent.height
                anchors.centerIn: parent
                property string idVel: "engine12"
            }
        }
        Rectangle {
            Layout.minimumWidth:  Math.floor(parent.width / 10)*2
            Layout.minimumHeight: parent.height
            // border.color: "red"
            color: "transparent"
            Column {
                anchors.centerIn: parent
                anchors.top: parent.top
                width: Math.floor(parent.parent.width / 10)*2
                height: parent.parent.height
                Rectangle{
                    height: parent.height/2
                    width: parent.width
                    // border.color: "red"
                    color: "transparent"
                    VelCircle {
                        id: velCircle1
                        property int ppmPorcent:0
                        RotationAnimation on rotation {
                            id: animationVel1;
                            from: 0
                            to: 360
                            duration: 1
                            running: true; onStopped: start()
                        }
                        anchors.centerIn: parent; property string idVel: "vel11"
                    }
                }
                Rectangle {
                    height: parent.height/2
                    width: parent.width
                    //border.color: "red"
                    color: "transparent"
                    VelCircle {
                        id: velCircle2
                        property int ppmPorcent:0
                        anchors.centerIn: parent
                        property string idVel: "vel12"
                    }
                }
            }

        }
    }
}
