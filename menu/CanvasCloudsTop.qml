import QtQuick 2.0

Canvas {
    id: mycanvas
    width: getWidth(parent)/2
    height: getWidth(parent)/2
    smooth: true
    anchors.horizontalCenter: parent.horizontalCenter
    onPaint: {
        var ctx     = getContext("2d");
        var centerX = mycanvas.width / 2
        var centerY = mycanvas.height / 2
        var i = 0
        var nObjects = 6
        var degFinal = 360 / nObjects

        ctx.strokeStyle = 'rgba(220,87,34,0.8)';
        ctx.lineWidth = 3;

        for(i=0;i<nObjects;i++) {
            var iTemp = i;
            iTemp++;
            if(iTemp % 2 === 0) {
                ctx.beginPath();
                ctx.arc(centerX, centerY, centerY*0.9, Math.PI/3*iTemp, Math.PI/3*(iTemp+1),false);
                ctx.arc(centerX, centerY, centerY*0.2, Math.PI/3*iTemp, Math.PI/3*(iTemp+1),false);
                ctx.arc(centerX, centerY, centerY*0.9, Math.PI/3*iTemp, Math.PI/3*(iTemp+1),false);
                ctx.stroke();
            }
        }
    }
    RotationAnimation on rotation { from: 360; to: 0; duration: 4000; running: true; loops: Animation.Infinite }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
}
