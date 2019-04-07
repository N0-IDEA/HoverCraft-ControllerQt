import QtQuick 2.0



Canvas {
    id: canvasGraph;
    width: 500
    height: 500
    property int paintY: 10;

    onPaint:{
        var ctx = canvasGraph.getContext('2d');
        ctx.beginPath();
        ctx.font = "normal 12px serif";
        ctx.fillStyle = "#ff0000";
        ctx.strokeRect(10, paintY, 160, 30);
        ctx.fillRect(10, paintY, 160, 30);
        ctx.closePath();
        ctx.save();
    }

    Timer {
        interval: 16
        running: true
        repeat: true
        onTriggered: {
            canvasGraph.requestPaint();
            canvasGraph.paintY += 10
            if (canvasGraph.paintY > canvasGraph.height)
                canvasGraph.paintY = 10
        }
    }
}




























/*
Canvas {id: alguno
    width:100; height:100;
    property int count: 0
    property var ctx
    onAvailableChanged: {if (available) ctx = getContext('2d');
        count++
    }
    onPaint: {
        if (!ctx) return;
        ctx.clearRect(0, 0, width, height);
        ctx.fillStyle = "white"
        ctx.fillText(alguno.count,20,20);
        requestAnimationFrame(paint);
    }
}*/
