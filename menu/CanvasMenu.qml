import QtQuick 2.0
import "../js/Clouds/Clouds.js" as Clouds
//import "../js/Lightning/Lightning.js" as Lightning
import QtQuick.Controls.Material 2.12

Canvas {

    id: canvasClouds
    property string path: '../media/fog.png'
    property variant utils: ({})
    property variant grid: ({})
    property variant square: ({})
    property variant fog: ({})
    property real angle
    property int fps
    property int fogDensity: 50
    width: parent.width
    height: parent.height
    smooth: true
    Timer {
        id: repaintTimer
        running: false
        interval: 2
        onTriggered: {
            context.clearRect(0, 0, canvasClouds.width, canvasClouds.height)
            canvasClouds.requestPaint()
        }
    }
    onImageLoaded: { canvasClouds.requestPaint() }
    //onCanvasSizeChanged: {canvasClouds.fog = new Fog( canvasClouds.fogDensity, 1, canvasClouds.path)}
    onPaint: {
        var ctx     = getContext("2d");
        if(!isImageLoaded(canvasClouds.path)){
            canvasClouds.loadImage(canvasClouds.path)
            return
        }

        ctx.fillStyle = Material.color(Material.DeepOrange);//#ff5722
        ctx.font = "100px ubuntu";
        ctx.strokeStyle = 'white';

        if( Object.keys(canvasClouds.fog).length === 0 && canvasClouds.fog.constructor === Object){
            canvasClouds.fog = new Clouds.Fog(ctx, canvasClouds.fogDensity, 2, canvasClouds.path)
            repaintTimer.start()
            return
        }

        canvasClouds.fog._render()
        //var algo = new Lightning.Segment(2, 50, 100);
        repaintTimer.start()
    }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
}

