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
    renderStrategy: Canvas.Threaded
    renderTarget: Canvas.FramebufferObject
    contextType: "2d"
    property variant app: ({})
    property int fps: 1
    onPainted: {
        console.log("ha sido pintado")
        canvasMenu.requestPaint();
    }
    onPaint: {
        // var ctx     = getContext("2d");
        console.timeEnd( "t" )
        if ( context ) {
            var repaintTimer;
            if( Object.keys(canvasMenu.app).length === 0 && canvasMenu.app.constructor === Object){
                canvasMenu.app = new App.App(context, canvasMenu.width, canvasMenu.height,repaintTimer);
                return
            }
            //canvasMenu.requestAnimationFrame(
                        canvasMenu.app.render(repaintTimer)//);
           /* delay(1000, function() {
                        console.log("And I'm printed after 1 second!")

                    })*/

        }
        console.time("t")
    }
    Timer {
            id: timer
        }

        function delay(delayTime, cb) {
            timer.interval = delayTime;
            timer.repeat = false;
            timer.triggered.connect(cb);
            timer.start();
        }
}

