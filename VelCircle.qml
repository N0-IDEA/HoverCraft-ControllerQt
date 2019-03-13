import QtQuick 2.0
import QtQuick.Controls.Material 2.12


Canvas {
    property string mycanvas: idVel
    property int porcent: ppmPorcent
    id: mycanvas
    width: getWidth(parent)
    height: getWidth(parent)
    rotation: 270
    smooth: true
    property int porState: 1
    onPaint: {
        var ctx = getContext("2d");
        var centerX=getWidth(mycanvas)/2;
        var centerY=centerX;
        var lineCircle = Math.floor(100/getWidth(mycanvas));
        var radioCirculo = centerX *0.9;
        var nObjects = 16
        var degFinal = 360 / nObjects
        var arrColors = getColorByPorc(
                    porcent, nObjects, "#000000", "#FFECA2", "#212121", "#FF5722", "#FF0000", "#000000")

        ctx.clearRect(0, 0, mycanvas.width, mycanvas.height);
        ctx.beginPath();
        ctx.arc(centerX, centerY, radioCirculo, 0, Math.PI*2, true);
        ctx.fillStyle = 'transparent';
        ctx.fill();
        ctx.lineWidth = 2;
        ctx.strokeStyle = Material.color(Material.DeepOrange)//'#7CC1CC';
        ctx.stroke();

        for(var i=0;i<nObjects;i++) {
            var start_x = centerX+Math.round((centerX-radioCirculo*1.8)*Math.cos(degFinal*i*Math.PI/180));
            var start_y = centerY+Math.round((centerY-radioCirculo*1.8)*Math.sin(degFinal*i*Math.PI/180));
            ctx.beginPath();
            var rMiniC =Math.floor(radioCirculo*0.08)
            ctx.arc(start_x,start_y,2,0,Math.PI*2,true);
            ctx.fillStyle = arrColors[i];
            ctx.fill();
        }
    }
    function getColorByPorc(porc,elements, color1, color2, color3, color4,color5,color6,color7){
        var arr = []
        var limitElements = 64
        var colors = [color1, color2, color3, color4,color5,color6,color7]

        if(porc < 0)
            porc = 0;
        porc = Math.ceil(porc) % 2 == 0? porc : Math.ceil(porc) ? porc + 1 : 0
        for (var e = 0; e <= limitElements; e++){
            var porcElements = Math.round((e / limitElements) * 100)
            var porcElementsFixed = porcElements % 2 == 0 ? porcElements : porcElements ? porcElements + 1 : 0
            if(porc === porcElementsFixed){
                var currentUnits = e/16
                if(currentUnits <= 1){
                    arr = getDegraded(colors[0], colors[0], elements - e)
                    arr = arr.concat(getDegraded(colors[2], colors[1], e))
                }else
                    if(currentUnits <= 2){
                        arr = getDegraded(colors[2], colors[1],  elements*2 - e)
                        arr = arr.concat(getDegraded(colors[2], colors[3], e - elements))
                    }else
                        if(currentUnits <= 3){
                            arr = getDegraded(colors[2], colors[3], elements*3 - e)
                            arr = arr.concat(getDegraded(colors[3], colors[4], e - elements*2))
                        }else
                            if(currentUnits <= 4){
                                arr = getDegraded(colors[3], colors[4], elements*4 - e)
                                arr = arr.concat(getDegraded(colors[5], colors[4],e - elements*3 ))
                            }
            }
        }
         return arr
    }
    function getWidth(item) {
        return item.width < item.height ? item.width : item.height
    }
    function processHEX(val) {
        var hex = (val.length >6)?val.substr(1, val.length - 1):val;
        if (hex.length > 3) {
            var r = hex.substr(0, 2);
            var g = hex.substr(2, 2);
            var b = hex.substr(4, 2);
        } else {
            var r = hex.substr(0, 1) + hex.substr(0, 1);
            var g = hex.substr(1, 1) + hex.substr(1, 1);
            var b = hex.substr(2, 1) + hex.substr(2, 1);
        }
        return [
                    parseInt(r, 16),
                    parseInt(g, 16),
                    parseInt(b, 16)
                ]
    }

    function getDegraded(val1El,val2El,steps) {
        var hasSpun = 0;
        var val1RGB = processHEX(val1El);
        var val2RGB = processHEX(val2El);
        var colors = [
                ];
        var stepsInt = parseInt(steps, 10);
        var stepsPerc = 100 / (stepsInt+1);
        var valClampRGB = [
                    val2RGB[0] - val1RGB[0],
                    val2RGB[1] - val1RGB[1],
                    val2RGB[2] - val1RGB[2]
                ];

        for (var i = 0; i < stepsInt; i++) {
            var clampedR = (valClampRGB[0] > 0)
                    ? pad((Math.round(valClampRGB[0] / 100 * (stepsPerc * (i + 1)))).toString(16), 2)
                    : pad((Math.round((val1RGB[0] + (valClampRGB[0]) / 100 * (stepsPerc * (i + 1))))).toString(16), 2);

            var clampedG = (valClampRGB[1] > 0)
                    ? pad((Math.round(valClampRGB[1] / 100 * (stepsPerc * (i + 1)))).toString(16), 2)
                    : pad((Math.round((val1RGB[1] + (valClampRGB[1]) / 100 * (stepsPerc * (i + 1))))).toString(16), 2);

            var clampedB = (valClampRGB[2] > 0)
                    ? pad((Math.round(valClampRGB[2] / 100 * (stepsPerc * (i + 1)))).toString(16), 2)
                    : pad((Math.round((val1RGB[2] + (valClampRGB[2]) / 100 * (stepsPerc * (i + 1))))).toString(16), 2);
            colors[i] = [
                        '#',
                        clampedR,
                        clampedG,
                        clampedB
                    ].join('');
        }
        /*colors.forEach(function (item){
                   console.log(item)
               })*/
        return colors;
    }
    function pad(n, width, z) {
        z = z || '0';
        n = n + '';
        return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
    }
    function porc(numerator, denominator){
        return numerator/denominator * 100;
    }
}
