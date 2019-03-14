import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

Canvas {
    id: canvas
    width: getWidth(parent)
    height: getWidth(parent)
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
            var coord2B = drawLineAngleCoord(ctx, coord1B, 25, 0);

            ctx.fillText(option, coord2B.x + 10, coord2B.y + fontSize / 2);
        }

        var idGamepad = 0;

        var ctx = getContext("2d");
        ctx.reset();
        var fontSize= 15;
        ctx.font = fontSize +"pt audiowide";
        ctx.fillStyle = "#FFFFFF";
        ctx.strokeStyle = "#FFFFFF";
        //Canvas of 800 * 800
        var canvasSize = 600;

        var canvasHalf = canvasSize / 2
        var buttonsPosx = canvasHalf + 80;
        var buttonsPosy = canvasHalf - 60;
        //Boton 1
        var option;
        if((option = findOption(idGamepad,0)) !== null)
            drawOptionButton(ctx, buttonsPosx, buttonsPosy + 50, 125, 60, option.option);

        //Boton 2
        if((option = findOption(idGamepad,1)) !== null)
            drawOptionButton(ctx, buttonsPosx + 50, buttonsPosy + 50, 75, 60, option.option);

        //Boton 3
        if((option = findOption(idGamepad,2)) !== null)
            drawOptionButton(ctx, buttonsPosx + 100, buttonsPosy + 50, 25, 60, option.option);

        //Boton 4
        if((option = findOption(idGamepad,3)) !== null)
            drawOptionButton(ctx, buttonsPosx, buttonsPosy - 50, 85, 300, option.option);

        //Boton 5
        if((option = findOption(idGamepad,4)) !== null)
            drawOptionButton(ctx, buttonsPosx + 50, buttonsPosy - 50, 50, 300, option.option);

        //Boton 6
        if((option = findOption(idGamepad,5)) !== null)
            drawOptionButton(ctx, buttonsPosx + 100, buttonsPosy - 50, 15, 300, option.option);

        //Boton 10
        if((option = findOption(idGamepad,9)) !== null) {
            var coords1B10 = drawLineAngle(ctx, canvasHalf + 15, canvasHalf + 15, 90, 55);
            ctx.fillText(option.option, coords1B10.x - ctx.measureText(option.option).width/2, coords1B10.y + fontSize + 10);
        }

        //Boton 9
        if((option = findOption(idGamepad,8)) !== null) {
            var coords1B9 = drawLineAngle(ctx, canvasHalf - 15, canvasHalf + 15, 90, 125);
            ctx.fillText(option.option, coords1B9.x - ctx.measureText(option.option).width/2, coords1B9.y + fontSize + 10);
        }

        //Boton 11
        if((option = findOption(idGamepad,10)) !== null) {
            var coords1B11 = drawLineAngle(ctx, canvasHalf, canvasHalf - 70, 80, 270);
            ctx.fillText(option.option, coords1B11.x - ctx.measureText(option.option).width/2, coords1B11.y - fontSize )
        }

        //Boton 12
        if((option = findOption(idGamepad,11)) !== null) {
            var coords1B12 = drawLineAngle(ctx, canvasHalf, canvasHalf - 25, 170, 90);
            ctx.fillText(option.option, coords1B12.x - ctx.measureText(option.option).width/2, coords1B12.y + fontSize + 10);
        }

        var posxAxis =  canvasHalf - canvasHalf /2;
        var posyAxis =  canvasHalf - canvasHalf /8;
        var marginAxis = 25;

        //Axis1
        if((option = findOptionAxis(idGamepad,1,1)) !== null) {
            var coords1A1 = drawLineAngle(ctx, posxAxis, posyAxis + marginAxis, 30, 90);
            ctx.fillText(option.option, coords1A1.x - ctx.measureText(option.option).width/2, coords1A1.y + fontSize + 10);
        }

        //Axis2
        if((option = findOptionAxis(idGamepad,0,1)) !== null) {
            var coords1A2 = drawLineAngle(ctx, posxAxis + marginAxis, posyAxis, 30, 0);
            ctx.fillText(option.option, coords1A2.x + 10, coords1A2.y + fontSize/2);
        }

        //Axis3
        if((option = findOptionAxis(idGamepad,0,-1)) !== null) {
            var coords1A3 = drawLineAngle(ctx, posxAxis - marginAxis, posyAxis, 30, 180);
            ctx.fillText(option.option, coords1A3.x - ctx.measureText(option.option).width - 10, coords1A3.y + fontSize /2);
        }
        //Axis4
        if((option = findOptionAxis(idGamepad,1,-1)) !== null) {
            var coords1A4 = drawLineAngle(ctx, posxAxis, posyAxis - marginAxis, 30, 270);
            ctx.fillText(option.option, coords1A4.x - ctx.measureText(option.option).width/2, coords1A4.y - fontSize + 10);
        }
    }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
}
