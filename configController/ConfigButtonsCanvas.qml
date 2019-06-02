import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs.qml 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

Canvas {
    id: canvasOption
    anchors.fill: parent
    property int gamepad: 0;
    onPaint: {
        function getCanvasCoord() {
            var newWidth, newHeight;

            var maxWidth = width;
            var maxHeight = height;
            var localWidth = 6016;
            var localHeight = 4016;
            var ratioW = maxWidth / localWidth;  // Width ratio
            var ratioH = maxHeight / localHeight;  // Height ratio

            if(ratioH > ratioW){
                newWidth = maxWidth;
                newHeight = localHeight * ratioW;
            }
            else{
                newWidth = localHeight * ratioH;
                newHeight = maxHeight;
            }

            return {
                width: newWidth,
                height: newHeight
            }
        }

        function drawLineAngle(context, posx, posy, length, angle) {
            context.beginPath();
            context.lineCap = 'round';
            context.lineWidth = 3;
            //context.strokeStyle = '#000';
            context.moveTo(posx + x, posy + y);
            var radians = Math.PI * angle / 180;
            var posxCalc = posx + length * Math.cos(radians);
            var posyCalc =  posy + length * Math.sin(radians);
            context.lineTo(posxCalc + x, posyCalc + y);
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
            context.moveTo(posx1 + x, posy1 + y);
            context.lineTo(posx2 + x, posy2 + y);
            context.stroke();
        }

        function drawLineCoord(context, coord, posx2, posy2) {
            return drawLine(context, coord.x, coord.y, posx2, posy2);
        }

        function fillText(text, posx, posy) {
            ctx.fillText(text, posx + x, posy + y);
        }

        function drawOptionButton(ctx, posx, posy, length, angle, option) {
            var coord1B =drawLineAngle(ctx, posx, posy, length, angle);
            var coord2B = drawLineAngleCoord(ctx, coord1B, coords.height*0.041666667, 0);

            fillText(option, coord2B.x + coords.width*0.016666667, coord2B.y + fontSize / 2);
        }

        var idGamepad = canvasOption.gamepad;
        var ctx = getContext("2d");
        ctx.reset();
        var coords = getCanvasCoord();
        var fontSize= coords.width *0.018;
        ctx.font = fontSize +"pt audiowide";
        ctx.fillStyle = Material.color(Material.DeepOrange)
        ctx.strokeStyle = Material.color(Material.DeepOrange);


        var x = width/2 - coords.width/2;
        var y = height/2 - coords.height/2;

        var option;

        //Boton 6
        if((option = findOption(idGamepad,6)) !== null) {
            var coords1B6 = drawLineAngle(ctx, 0.4365026595744680851063829787234 * coords.width, 0.08964143426294820717131474103586 * coords.height, coords.height * 0.04940239043824701195219123505976, 220);
            var coords2B6 = drawLineAngle(ctx, coords1B6.x, coords1B6.y, coords.height * 0.04940239043824701195219123505976, 180);
            fillText(option.option, coords2B6.x - ctx.measureText(option.option).width - coords.width*0.016666667, coords2B6.y + fontSize / 2 );
        }

        //Boton 7
        if((option = findOption(idGamepad,7)) !== null) {
            var coords1B7 = drawLineAngle(ctx, 0.6333111702127659574468085106383 * coords.width, 0.08964143426294820717131474103586 * coords.height, coords.height * 0.04940239043824701195219123505976, 320);
            var coords2B7 = drawLineAngle(ctx, coords1B7.x, coords1B7.y, coords.height * 0.04940239043824701195219123505976, 0);
            fillText(option.option, coords2B7.x + coords.width*0.016666667 , coords2B7.y + fontSize / 2);
        }

        //Boton 8
        if((option = findOption(idGamepad,8)) !== null) {
            var coords1B8 = drawLineAngle(ctx, 0.49584441489361702127659574468085 * coords.width, 0.4424800796812749003984063745019 * coords.height, coords.height * 0.14940239043824701195219123505976, 125);
            fillText(option.option, coords1B8.x - ctx.measureText(option.option).width/2, coords1B8.y + fontSize + 10);
        }

        //Boton 9
        if((option = findOption(idGamepad,9)) !== null) {
            var coords1B9 = drawLineAngle(ctx, 0.57696143617021276595744680851064 * coords.width, 0.4424800796812749003984063745019 * coords.height, coords.height * 0.14940239043824701195219123505976, 55);
            fillText(option.option, coords1B9.x - ctx.measureText(option.option).width/2, coords1B9.y + fontSize + 10);
        }
        //Boton 0
        if((option = findOption(idGamepad,0)) !== null)
            drawOptionButton(ctx, 0.62815824468085106382978723404255 * coords.width, 0.4033864541832669322709163346613 * coords.height, coords.height * 0.17554780876494023904382470119522, 65, option.option);

        //Boton 1
        if((option = findOption(idGamepad,1)) !== null)
            drawOptionButton(ctx, 0.66539228723404255319148936170213 * coords.width, 0.375 * coords.height, coords.height * 0.11703187250996015936254980079681, 65, option.option);

        //Boton 2
        if((option = findOption(idGamepad,2)) !== null)
            drawOptionButton(ctx, 0.69647606382978723404255319148936 * coords.width, 0.34561752988047808764940239043825 * coords.height, coords.height * 0.05851593625498007968127490039841, 65, option.option);

        //Boton 3
        if((option = findOption(idGamepad,3)) !== null)
            drawOptionButton(ctx, 0.62200797872340425531914893617021 * coords.width, 0.32694223107569721115537848605578 * coords.height, coords.height * 0.17554780876494023904382470119522, 300, option.option);

        //Boton 4
        if((option = findOption(idGamepad,4)) !== null)
            drawOptionButton(ctx, 0.64777260638297872340425531914894 * coords.width, 0.30378486055776892430278884462151 * coords.height, coords.height * 0.11703187250996015936254980079681, 300, option.option);

        //Boton 5
        if((option = findOption(idGamepad,5)) !== null)
            drawOptionButton(ctx, 0.67154255319148936170212765957447 * coords.width, 0.28361553784860557768924302788845 * coords.height, coords.height * 0.05851593625498007968127490039841, 300, option.option);

        //Boton 10
        if((option = findOption(idGamepad,10)) !== null) {
            var coords1B11 = drawLineAngle(ctx, 0.53490691489361702127659574468085 * coords.width, 0.33316733067729083665338645418327 * coords.height, coords.height * 0.14940239043824701195219123505976, 270);
            fillText(option.option, coords1B11.x , coords1B11.y - fontSize )
        }

        //Boton 11
        if((option = findOption(idGamepad,11)) !== null) {
            var coords1B12 = drawLineAngle(ctx, 0.53490691489361702127659574468085 * coords.width, 0.38122509960159362549800796812749 * coords.height, coords.height * 0.224103586, 90);
            fillText(option.option, coords1B12.x - ctx.measureText(option.option).width/2, coords1B12.y + fontSize + coords.height*0.016666667);
        }

        //2518/6016
        var posxAxis = 0.418550532 * coords.width;
        //1400/4016
        var posyAxis = 0.348605578 * coords.height;
        //200/6016
        var marginAxis = 0.033244681 * coords.width;

        //Axis1
        if((option = findOptionAxis(idGamepad,1,1)) !== null) {
            var coords1A1 = drawLineAngle(ctx, posxAxis, posyAxis + marginAxis, coords.height*0.05, 90);
            fillText(option.option, coords1A1.x - ctx.measureText(option.option).width/2, coords1A1.y + fontSize + coords.height *0.016666667);
        }

        //Axis2
        if((option = findOptionAxis(idGamepad,0,1)) !== null) {
            var coords1A2 = drawLineAngle(ctx, posxAxis + marginAxis, posyAxis, coords.height*0.07, 0);
            var coords2A2 = drawLineAngle(ctx, coords1A2.x, coords1A2.y, coords.height * 0.23553585657370517928286852589641, 270);
            fillText(option.option, coords2A2.x - fontSize/2 , coords2A2.y - fontSize/2);
        }

        //Axis3
        if((option = findOptionAxis(idGamepad,0,-1)) !== null) {
            var coords1A3 = drawLineAngle(ctx, posxAxis - marginAxis, posyAxis, coords.height*0.05, 180);
            fillText(option.option, coords1A3.x - ctx.measureText(option.option).width - coords.height*0.016666667, coords1A3.y + fontSize /2);
        }
        //Axis4
        if((option = findOptionAxis(idGamepad,1,-1)) !== null) {
            var coords1A4 = drawLineAngle(ctx, posxAxis, posyAxis - marginAxis, coords.height*0.05, 270);
            fillText(option.option, coords1A4.x - ctx.measureText(option.option).width/2, coords1A4.y - fontSize);
        }
    }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
}
