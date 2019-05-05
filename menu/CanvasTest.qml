import QtQuick 2.0
import "../js/Clouds/Clouds.js" as Clouds
import "../js/Lightning/Lightning.js" as Lightning
import "../js/Lightning/Vec2.js" as Vec2
import QtQuick.Controls.Material 2.12

Canvas {
    id: canvasMenu
    width: parent.width
    height: parent.height
    smooth: true
    renderStrategy: Canvas.Threaded
    renderTarget: Canvas.FramebufferObject
    property variant app: ({})
    property int fps: 1
    onPainted: {
       // console.log("ha sido pintado");
        delay(20, function(){ canvasMenu.requestPaint() })
    }
    onPaint: {
        var ctx = getContext("2d");
     //   console.timeEnd( "t" )
        var bolts = [];
        var dimensions = new Vec2.Vector2();
        var center = new Vec2.Vector2();
        dimensions.x = canvasMenu.width;
        dimensions.y =  canvasMenu.height;
        center.x =   dimensions.x * 0.5;
        center.y =   dimensions.y * 0.5;
        ctx.lineWidth = 3;
        var randomInt;
        var i = 0;

        if ( context ) {
            var repaintTimer;
            randomInt = Math.round(Math.random() * 60);
            fps++;
           // console.log(  fps)
            if (  fps % randomInt === 0) {
                for (i = 0 ; i < 2; i++){
                    var positionXTop = Math.random() * ( dimensions.x*0.7 - dimensions.x*0.3) + dimensions.x*0.3;
                    var positionX = Math.round(Math.random() * dimensions.x);
                    var thunder = new Lightning.Lightning(
                                new Vec2.Vector2( positionXTop , titleMenu.y + titleMenu.height/2),
                                new Vec2.Vector2(positionX, dimensions.y),
                                5 )
                  //  console.log(thunder);
                    bolts.push( thunder );
                }
            }
            ctx.fillStyle = "rgba(0,0,0,0.5)";
            ctx.fillRect(0, 0,   dimensions.x,   dimensions.y);
            ctx.save();
            ctx.shadowColor = "rgba(255,26,2,0.9)";
            ctx.shadowBlur = 10;
            ctx.beginPath();

            if (  bolts.length > 0) {
                var segment;
                var bolt;
                for (i = bolts.length - 1; i >= 0; i--) {
                    bolt = bolts[i];
                    bolt.update();
                    ctx.strokeStyle = "rgba(255,194,191," + bolt.alpha.toString() + ")";
                    for (var j = 0, len = bolt.segments.length; j < len; j++) {
                        segment = bolt.segments[j];
                        ctx.moveTo(segment.start.x, segment.start.y);
                        ctx.lineTo(segment.end.x, segment.end.y);
                    }
                    if (bolt.life > bolt.ttl)  {
                        bolts.splice(i, 1);
                        ctx.clearRect(0, 0,   dimensions.x,   dimensions.y);
                    };
                }
            }
            ctx.stroke();
            ctx.fill();
            ctx.restore();

            if (  bolts.length > 0) {
                txt2.color = "#FFC2BF";
                txt2.color = "transparent";
            }
        };
        //console.time("t")
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

