import QtQuick 2.0
import QtQuick 2.12
import "../js/Clouds/Clouds.js" as Clouds
import "../js/Lightning/Lightning.js" as Lightning
import "../js/Lightning/Vec2.js" as Vec2
import QtQuick.Controls.Material 2.12

Canvas {
    id: canvasTitleLigt
    width: parent.width
    height: parent.height
    smooth: true
    renderStrategy: Canvas.Threaded
    renderTarget: Canvas.FramebufferObject
    property variant app: ({})
    property int fps: 1
    property int count: 10
    property double flashOpacity: 0.0
    onPainted: {
      //  console.log("ha sido pintado");
        delay(30, function (){ canvasTitleLigt.requestPaint() } )
    }
    onPaint: {
        var ctx     = getContext("2d");
        //console.timeEnd( "t" )

        var ellipse = ({});
        ellipse.center = new Vec2.Vector2();
        ellipse.center.x = canvasTitleLigt.width/2
        ellipse.center.y = canvasTitleLigt.height/4
        ellipse.radio = new Vec2.Vector2();
        ellipse.radio.x = 400
        ellipse.radio.y = 300
        ellipse.rotation = Math.PI * .25
        var circle = {
            x: width/2,
            y: titleMenu.y+titleMenu.height/2,
            radius:  ( width/2 / 15),
            speed: 2,
            rotation: 0,
            angleStart: 270,
            angleEnd: 90,
            hue: 20,
            thickness: 10,
            blur: 5
        }
        clear(ctx, width, height)
        if ( context ) {

            ctx.save()

            ctx.shadowBlur = circle.blur;
            ctx.shadowColor = 'hsla('+ circle.hue +', 80%, 60%, 1)';
            ctx.lineCap = 'round'

            var gradient2 = ctx.createLinearGradient(0, -circle.radius, 0, circle.radius);
            gradient2.addColorStop(0, 'hsla('+ circle.hue +', 100%, 50%, 0)');
            gradient2.addColorStop(.1, 'hsla('+ circle.hue +', 100%, 100%, .7)');
            gradient2.addColorStop(1, 'hsla('+ circle.hue +', 100%, 50%, 0)');

            ctx.strokeStyle = "white"
            ctx.fillStyle = "white"
            var rectWidth = titleMenu.width+ titleMenu.x *0.75
            ctx.fillRect( titleMenu.x * 0.65, circle.y,
                          rectWidth, titleMenu.height*0.3);

            ctx.strokeRect( titleMenu.x * 0.65, circle.y,
                            rectWidth, titleMenu.height*0.3);

            ctx.restore()
        };
       // console.time("t")

    }
    Timer {
        id: timer2
        interval: 20
        running: true
    }
    function clear (ctx, width, height){
        ctx.globalCompositeOperation = 'destination-out';
        ctx.fillStyle = 'rgba(0, 0, 0, .1)';
        ctx.fillRect(0, 0, width, height);
        ctx.globalCompositeOperation = 'lighter';
    }
    function dToR(degrees){ return degrees * (Math.PI / 180); }
    function delay(delayTime, cb) {
        timer2.interval = delayTime;
        timer2.repeat = false;
        timer2.triggered.connect(cb);
        timer2.start();
    }
}

