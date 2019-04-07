import QtQuick 2.0
//import "../js/Utils/Utils.js" as Utils
//import "../js/Grid/Grid.js" as Grid
//import "../js/Square/Square.js" as Square
import "../js/Clouds/Clouds.js" as Clouds
import QtQuick.Controls.Material 2.12

Canvas {

    id: canvasMenu
    property string path: '../media/fog.png'
    property variant utils: ({})
    property variant grid: ({})
    property variant square: ({})
    property variant fog: ({})
    property real angle
    property int fps
    property int fogDensity: 50

    //property var ctx
    //onAvailableChanged: if (available) ctx = getContext('2d');
    width: parent.width
    height: parent.height
    smooth: true
    Timer {
        id: repaintTimer
        running: false
        interval: 0
        onTriggered: {
            context.clearRect(0, 0, canvasMenu.width, canvasMenu.height)
            canvasMenu.requestPaint()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {   }
    }

    onImageLoaded: { canvasMenu.requestPaint() }
    //onCanvasSizeChanged: {canvasMenu.fog = new Fog( canvasMenu.fogDensity, 1, canvasMenu.path)}
    onPaint: {
        var ctx     = getContext("2d");
        if(!isImageLoaded(canvasMenu.path)){
            canvasMenu.loadImage(canvasMenu.path)
            return
        }

        ctx.fillStyle = Material.color(Material.DeepOrange);
        ctx.font = "100px ubuntu";
        ctx.strokeStyle = 'white';

        if( Object.keys(canvasMenu.fog).length === 0 && canvasMenu.fog.constructor === Object){
            canvasMenu.fog = new Clouds.Fog(ctx, canvasMenu.fogDensity, 2, canvasMenu.path)
            repaintTimer.start()
            return
        }
        canvasMenu.fog._render()
        repaintTimer.start()
    }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
}

