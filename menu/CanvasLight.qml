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
        console.log("ha sido pintado");
        //        delay(20, function (){ canvasTitleLigt.context.scale(10, 10);} )
        delay(20, function (){ canvasTitleLigt.requestPaint() } )
    }
    onPaint: {
        var ctx     = getContext("2d");
        console.timeEnd( "t" )
        /*   var
        wid = canvasTitleLigt.width,
        hei = canvasTitleLigt.height,
        ang = -90 * Math.PI/180,
        spn = 80 * Math.PI/180,
        ctr = {x: 200, y:200},
        rad = 200,

        grd = ctx.createRadialGradient(ctr.x, ctr.y, 0, ctr.x, ctr.y, rad);
        grd.addColorStop(0, 'rgba(0,200,255,.25)');
        grd.addColorStop(0.75, 'rgba(0,0,0,0.25)');
        grd.addColorStop(1, 'rgba(0,0,0,0)');
        ctx.fillStyle = grd;*/

        var ellipse = ({});
        ellipse.center = new Vec2.Vector2();
        ellipse.center.x = canvasTitleLigt.width/2
        ellipse.center.y = canvasTitleLigt/4
        ellipse.radio = new Vec2.Vector2();
        ellipse.radio.x = 400
        ellipse.radio.y = 300
        ellipse.rotation = Math.PI * .25


        if ( context ) {
            /* ctx.clearRect(0,0,wid,hei);
            ang = Math.sin(new Date()/1000) * Math.PI/2;
            spn = (Math.abs(Math.sin(new Date()/1000/3)) * 120 + 30) * Math.PI/180;

            for (var i = 2; i < 10; i+=0.1){
                ctx.beginPath();
                ctx.moveTo(ctr.x,ctr.y);
                ctx.arc(ctr.x, ctr.y, rad, ang - spn/i, ang + spn/i, false);
                ctx.closePath();
                ctx.fill();
            }*/
            ctx.fillStyle = 'red';
            ctx.beginPath();
            var radioX = 100, radioY = 60, rotacion=0, ap = 0, af = 2*Math.PI, cR = true;
                        var elipWidth = titleMenu.width*1.6
                        var elipHeight = titleMenu.height*2
                        context.ellipse(titleMenu.x - titleMenu.width*0.25,
                                        titleMenu.y - titleMenu.height*0.25 , elipWidth, elipHeight,
            rotacion, ap, af, cR);
            ctx.fillStyle = "rgba(255,87,34,0.2)"//Material.color(Material.DeepOrange);
            ctx.fill()
            ctx.beginPath();
            ctx.arc(width/2, titleMenu.y+titleMenu.height/2,
                    titleMenu.height/2,0, Math.PI*2,false);
            ctx.strokeStyle = "white"
            ctx.stroke()
            //            ctx.save()
            //             ctx.translate(ellipse.center.x, ellipse.center.y)
            //             ctx.rotate((Math.PI / 180) * 15)
            //             ctx.translate(-ellipse.center.x, -ellipse.center.y)
            //             ctx.restore()
        };
        console.time("t")
    }
    Timer {
        id: timer2
        interval: 20
        running: true
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
        timer2.interval = delayTime;
        timer2.repeat = false;
        timer2.triggered.connect(cb);
        timer2.start();
    }
}

