import QtQuick 2.0

Canvas {
    //property string mycanvas: idVel
    id: mycanvas
    width: parent.width
    height: parent.height
    smooth: true
    onPaint: { //outer and inner circle , take a 3 parts of this and lines
        var ctx     = getContext("2d");
        var centerX = getWidth(mycanvas)/2;
        var centerY = centerX
        var rCicle = centerX*0.95;
        var i = 0
        var rMiniCircle = rCicle * 0.26;
        var nObjects = 3
        var degFinal = 360 / nObjects
        for(i=0;i<nObjects;i++) {
            var start_x = centerX +
                    Math.round((centerX-rMiniCircle*2)*Math.cos(degFinal*i*Math.PI/180));
            var start_y = centerY +
                    Math.round((centerY-rMiniCircle*2)*Math.sin(degFinal*i*Math.PI/180));
            var end_x = centerX+Math.round((centerX)*Math.cos(degFinal*i*Math.PI/180));

            var end_y = centerY+Math.round((centerY)*Math.sin(degFinal*i*Math.PI/180));
            ctx.beginPath();
            ctx.arc(centerX,start_y,start_x,Math.PI*2,Math.PI*1.5,true);
           // ctx.arc(centerX,end_y,rMiniCircle*0.5,Math.PI*2,Math.PI*1.5,true);
            //ctx.moveTo(start_x,start_y);
            //ctx.lineTo(end_x,end_y);
            ctx.strokeStyle = '#434b4d';
            ctx.stroke();
           /* ctx.beginPath();
            ctx.arc(start_x,start_y,rMiniCircle*0.5,0,Math.PI,true);
            ctx.lineWidth = 2;
            ctx.strokeStyle = '#434b4d';
            ctx.stroke();*/
        }
    }
    //RotationAnimation on rotation { from: 360; to: 0; duration: 4000; running: true; loops: Animation.Infinite }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
}
