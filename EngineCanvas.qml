import QtQuick 2.0

Canvas {
    property string mycanvas: idVel
    id: mycanvas
    width: getWidth(parent)
    height: getWidth(parent)

    smooth: true
    rotation: 270
    onPaint: {
        var ctx     = getContext("2d");
        var centerX = getWidth(mycanvas)/2;
        var centerY = centerX
        var rCicle = centerX*0.95;

        ctx.beginPath();
        ctx.arc(centerX, centerY, rCicle, 0, Math.PI*2, true);
        ctx.fillStyle = '#cf1020';
        ctx.fill();
        ctx.lineWidth = rCicle*0.01;
        ctx.strokeStyle = '#0F1B23';
        ctx.stroke();

        ctx.beginPath();
        ctx.arc(centerX, centerY, rCicle*0.8, 0, Math.PI*2, true);
        ctx.fillStyle = 'black';
        ctx.fill();
        ctx.lineWidth = rCicle*0.15;
        ctx.strokeStyle = '#434b4d';
        ctx.stroke();

        ctx.beginPath();
        ctx.arc(centerX, centerY, rCicle*0.2, 0, Math.PI*2, true);
        ctx.fillStyle = 'black';
        ctx.fill();
        ctx.lineWidth = rCicle*0.02;
        ctx.strokeStyle = '#434b4d';
        ctx.stroke();

        var R = rCicle*0.15;
        ctx.strokeStyle = '#434b4d';
        var rad = ( Math.PI / 180 ) * 60;
        ctx.beginPath();
        for( var i = 0; i<6; i++ ){
            var posX = centerX + R * Math.cos( rad *i);
            var posY = centerY + R * Math.sin( rad *i);
            ctx.lineTo(posX, posY);
        }
        ctx.closePath();
        ctx.stroke();

        ctx.beginPath();
        ctx.arc(centerX, centerY, rCicle*0.03, 0, Math.PI*2, true);
        ctx.fillStyle = 'grey';
        ctx.fill();
        ctx.lineWidth = rCicle*0.02;
        ctx.strokeStyle = '#434b4d';
        ctx.stroke();

        var rMiniCircle = rCicle * 0.26;

                var nObjects = 6
                var degFinal = 360 / nObjects
                for(i=0;i<nObjects;i++) {
                    var start_x = centerX+Math.round((centerX-rMiniCircle*2)*Math.cos(degFinal*i*Math.PI/180));
                    var start_y = centerY+Math.round((centerY-rMiniCircle*2)*Math.sin(degFinal*i*Math.PI/180));
                    ctx.beginPath();
                    ctx.arc(start_x,start_y,rMiniCircle*0.5,0,Math.PI*2,true);
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = '#434b4d';
                    ctx.stroke();
                }

    }
    RotationAnimation on rotation { from: 360; to: 0; duration: 4000; running: true; loops: Animation.Infinite }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
}
