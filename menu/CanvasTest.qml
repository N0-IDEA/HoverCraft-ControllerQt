import QtQuick 2.0
import "../js/Clouds/Clouds.js" as Clouds
import "../js/Lightning/Lightning.js" as Lightning
import "../js/Lightning/App.js" as App
import QtQuick.Controls.Material 2.12

Canvas {
    id: canvasMenu
    width: parent.width
    height: parent.height
    smooth: true
    property string path: '../media/fog.png'
    property variant app: ({})
    property int fps: 1
    Timer {
        id: repaintTimer
        running: true
        interval: 1

        onTriggered: {
            canvasMenu.requestPaint()
        }
    }
   /* Timer {
        interval: 1
        running: true
        repeat: true
        onTriggered: { repaintTimer.start()  }
    }*/
    onPaint: {
        var ctx     = getContext("2d");
        if( Object.keys(canvasMenu.app).length === 0 && canvasMenu.app.constructor === Object){
            canvasMenu.app = new App.App(ctx, canvasMenu.width, canvasMenu.height,repaintTimer);//,fps);
            return
        }
        canvasMenu.app.render(repaintTimer);//,fps);
    }
}

