import QtQuick 2.0
import QtQuick 2.12
import "../js/Clouds/Clouds.js" as Clouds
import "../js/Lightning/Lightning.js" as Lightning
import "../js/Lightning/Vec2.js" as Vec2
import "../js/Lightning/App.js" as App
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
    onPainted: {
        console.log("ha sido pintado");
//        delay(20, function (){ canvasTitleLigt.context.scale(10, 10);} )

        delay(20, function (){ canvasTitleLigt.requestPaint()} )
    }
    onPaint: {
        var ctx     = getContext("2d");
        console.timeEnd( "t" )
        /* clear(ctx, canvasTitleLigt.width, canvasTitleLigt.height);
        var rand = function(a,b){return ~~((Math.random()*(b-a+1))+a);}
        var   dToR = function(degrees){
            return degrees * (Math.PI / 180);
        }
        var circle = {
            x: canvasTitleLigt.width / 2,
            y: canvasTitleLigt.height /2,
            radius: 10,
            speed: 2,
            rotation: 0,
            hue: 220,
            thickness: 18,
            blur: 25
        }
*/
        if ( context ) {
            ctx.clearRect(0,0, canvasTitleLigt.width, canvasTitleLigt.height);
            context.lineWidth = 1;
            //context.strokeStyle = "#00f";
            var radioX = 100, radioY = 60, rotacion=0, ap = 0, af = 2*Math.PI, cR = true;
            var elipWidth = titleMenu.width*1.6
            var elipHeight = titleMenu.height*2
            context.ellipse(titleMenu.x - titleMenu.width*0.25, titleMenu.y - titleMenu.height*0.25 , elipWidth, elipHeight,
                            rotacion, ap, af, cR);
            context.stroke();
            ctx.fillStyle = Material.color(Material.DeepOrange);
            ctx.fill()
            /*          ctx.save();
            ctx.translate(circle.x, circle.y);
            ctx.rotate(dToR(circle.rotation+185));
            ctx.beginPath();
            ctx.arc(0, circle.radius, 30, 0, Math.PI *2, false);
            ctx.closePath();
            var gradient3 = ctx.createRadialGradient(0, circle.radius, 0, 0, circle.radius, 30);
            gradient3.addColorStop(0, 'hsla(330, 50%, 50%, .35)');
            gradient3.addColorStop(1, 'hsla(330, 50%, 50%, 0)');
            ctx.fillStyle = gradient3;
            ctx.fill();

            ctx.restore();*/
        };
        console.time("t")
    }
    Timer {
        id: timer
    }
    /*  ScaleAnimator {
        id: scaleUp
        target: canvasTitleLigt;
        from: 0.5;
        to: 2;
        duration: 1000
        running: true
    }
    ScaleAnimator {
        id: scaleDown
        target: canvasTitleLigt;
        from: 2;
        to: 0.5;
        duration: 1000
        running: false
    }
    Rotation {
        //angle:
    }
    onScaleChanged: { if (scaleUp.running) {
            scaleUp.running = false
            scaleDown.running = true
        } else {
            scaleUp.running = true
            scaleDown.running = false
        }

    }*/
    function clear (ctx, width, height){
        ctx.globalCompositeOperation = 'destination-out';
        ctx.fillStyle = 'rgba(0, 0, 0, .1)';
        ctx.fillRect(0, 0, width, height);
        ctx.globalCompositeOperation = 'lighter';
    }
    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

}

