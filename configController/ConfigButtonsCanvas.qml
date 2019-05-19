import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

Canvas {
    id: canvasOption
    anchors.fill: parent
    onPaint: {
        function drawLineAngle(context, posx, posy, length, angle) {
            context.beginPath();
            context.lineCap = 'round';
            context.lineWidth = 3;
            //context.strokeStyle = '#000';
            context.moveTo(posx, posy);
            var radians = Math.PI * angle / 180;
            var posxCalc = posx + length * Math.cos(radians);
            var posyCalc =  posy + length * Math.sin(radians);
            context.lineTo(posxCalc, posyCalc);
            context.stroke();
            context.closePath();

            return {
                x: posxCalc,
                y: posyCalc
            }
        }

        function drawLineAngleCoord(context, coord, length, angle) {
            return drawLineAngle(context, coord.x, coord.y, length, angle);
        }

        function drawLine(context, posx1, posy1, posx2, posy2) {
            context.moveTo(posx1, posy1);
            context.lineTo(posx2, posy2);
            context.stroke();
        }

        function drawLineCoord(context, coord, posx2, posy2) {
            return drawLine(context, coord.x, coord.y, posx2, posy2);
        }

        function drawOptionButton(ctx, posx, posy, length, angle, option) {
            var coord1B =drawLineAngle(ctx, posx, posy, length, angle);
            var coord2B = drawLineAngleCoord(ctx, coord1B, canvasSize*0.041666667, 0);

            ctx.fillText(option, coord2B.x + canvasSize*0.016666667, coord2B.y + fontSize / 2);
        }

        var idGamepad = 0;
        var canvasSize = width;
        var ctx = getContext("2d");
        ctx.reset();
        var fontSize= canvasSize*0.018;
        ctx.font = fontSize +"pt audiowide";
        ctx.fillStyle = "#FFFFFF";
        ctx.strokeStyle = "#FFFFFF";
        //Canvas of 800 * 800


        var canvasHalf = canvasSize / 2

        var buttonsPosx = (canvasSize - canvasSize*0.133)/2*1.25
        var buttonsPosy = (canvasHalf - canvasSize*0.1)/2

        var option;

        //Boton 8
        if((option = findOption(idGamepad,8)) !== null) {
            drawOptionButton(ctx, buttonsPosx + canvasSize*0.0833/4, buttonsPosy + canvasSize*0.0833, canvasSize*0.3, canvasSize*0.1, option.option);
        }
        //Boton 9
        if((option = findOption(idGamepad,9)) !== null) {
           drawOptionButton(ctx, buttonsPosx + canvasSize*0.0833/2, buttonsPosy + canvasSize*0.0833, canvasSize*0.3*0.8, canvasSize*0.1, option.option);
        }
        //Boton 0
        if((option = findOption(idGamepad,0)) !== null)
            drawOptionButton(ctx, buttonsPosx + canvasSize*0.0833, buttonsPosy + canvasSize*0.0833, canvasSize*0.3*0.6, canvasSize*0.1, option.option);


        //Boton 1
        if((option = findOption(idGamepad,1)) !== null)
            drawOptionButton(ctx, buttonsPosx + canvasSize*0.0833, buttonsPosy + canvasSize*0.0833, canvasSize*0.3*0.4, canvasSize*0.1, option.option);

        //Boton 2
        if((option = findOption(idGamepad,2)) !== null)
            drawOptionButton(ctx, buttonsPosx + canvasSize*0.1666, buttonsPosy + canvasSize*0.0833, canvasSize*0.3*0.2, canvasSize*0.1, option.option);

        //Boton 3
        if((option = findOption(idGamepad,3)) !== null)
            drawOptionButton(ctx, buttonsPosx + canvasSize*0.1666, buttonsPosy - canvasSize*0.0833, canvasSize*0.1, canvasSize/2, option.option);

        //Boton 4
        if((option = findOption(idGamepad,4)) !== null)
            drawOptionButton(ctx, buttonsPosx + canvasSize*0.0833, buttonsPosy - canvasSize*0.0833, canvasSize*0.0833, canvasSize/2, option.option);

        //Boton 5
        if((option = findOption(idGamepad,5)) !== null)
            drawOptionButton(ctx, buttonsPosx + canvasSize*0.1666, buttonsPosy - canvasSize*0.0833, canvasSize*0.025, canvasSize/2, option.option);

        //Boton 11
        /* if((option = findOption(idGamepad,10)) !== null) {
            var coords1B11 = drawLineAngle(ctx, canvasHalf, canvasHalf - canvasSize*0.116666667, canvasSize*0.133333333, 270);
            ctx.fillText(option.option, coords1B11.x , coords1B11.y - fontSize )
        }*/

        //Boton 12
        /*if((option = findOption(idGamepad,11)) !== null) {
            var coords1B12 = drawLineAngle(ctx, canvasHalf, canvasHalf - canvasSize*0.041666667, canvasSize*0.283333333, 90);
            ctx.fillText(option.option, coords1B12.x - ctx.measureText(option.option).width/2, coords1B12.y + fontSize + canvasSize*0.016666667);
        }*/

        var posxAxis =  (canvasHalf - canvasHalf /canvasSize*0.003333333)/2;
        var posyAxis =  (canvasHalf - canvasHalf /canvasSize*0.013333333)/2;
        var marginAxis = canvasSize*0.041666667;

        //Axis1
        if((option = findOptionAxis(idGamepad,1,1)) !== null) {
            var coords1A1 = drawLineAngle(ctx, posxAxis, posyAxis + marginAxis, canvasSize*0.05, 90);
            ctx.fillText(option.option, coords1A1.x - ctx.measureText(option.option).width/2, coords1A1.y + fontSize + canvasSize*0.016666667);
        }

        //Axis2
        if((option = findOptionAxis(idGamepad,0,1)) !== null) {
            var coords1A2 = drawLineAngle(ctx, posxAxis + marginAxis, posyAxis, canvasSize*0.05, 0);
            ctx.fillText(option.option, coords1A2.x + canvasSize*0.016666667, coords1A2.y + fontSize/2);
        }

        //Axis3
        if((option = findOptionAxis(idGamepad,0,-1)) !== null) {
            var coords1A3 = drawLineAngle(ctx, posxAxis - marginAxis, posyAxis, canvasSize*0.05, 180);
            ctx.fillText(option.option, coords1A3.x - ctx.measureText(option.option).width - canvasSize*0.016666667, coords1A3.y + fontSize /2);
        }
        //Axis4
        if((option = findOptionAxis(idGamepad,1,-1)) !== null) {
            var coords1A4 = drawLineAngle(ctx, posxAxis, posyAxis - marginAxis, canvasSize*0.05, 270);
            ctx.fillText(option.option, coords1A4.x - ctx.measureText(option.option).width/2, coords1A4.y - fontSize + canvasSize*0.016666667);
        }
    }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
}
