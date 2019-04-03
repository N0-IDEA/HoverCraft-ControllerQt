import QtQuick 2.0
import "../js/Utils/Utils.js" as Utils
import "../js/Grid/Grid.js" as Grid

Canvas {
    property string mycanvas: idVel
    property variant utils: ({})
    property variant grid: ({})
    id: canvasMenu
    width: getWidth(parent)
    height: getWidth(parent)
    smooth: true
    //rotation: 270
    onPaint: {
        var ctx     = getContext("2d");
        var centerX = getWidth(mycanvas)/2;
        var centerY = centerX

        ctx.fillStyle = 'white';
        ctx.font = "100px ubuntu";
        ctx.strokeStyle = 'white';
        //ctx.fillText( Utils.randomize(1,10), 100, 100);
        //var gridCanvasTemp = Grid.startDraw ();
        //gridCanvasTemp.fn.hello(ctx)

        var algo = centerX;


        canvasMenu.utils = new Utils.Utils();

        canvasMenu.grid = new Grid.Grid();

        ctx.fillText( canvasMenu.utils.randomize(1,10), 100, 100);
    }


    //  RotationAnimation on rotation { from: 360; to: 0; duration: 4000; running: true; loops: Animation.Infinite }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
}
