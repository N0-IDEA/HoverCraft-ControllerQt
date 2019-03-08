import QtQuick 2.0
import QtQuick.Controls.Material 2.12


Canvas {
    property string mycanvas: idVel
    id: mycanvas
    width: getWidth(parent)
    height: getWidth(parent)
    rotation: 270
    smooth: true
    property int porState: 1
    onPaint: {
        var ctx = getContext("2d");
        var centerX=getWidth(mycanvas)/2;
        var centerY=getWidth(mycanvas)/2;
        var lineCircle = Math.floor(100/getWidth(mycanvas));
        var radioCirculo = centerX *0.9;

        ctx.beginPath();
        ctx.arc(centerX, centerY, radioCirculo, 0, Math.PI*2, true);
        ctx.fillStyle = 'transparent';
        ctx.fill();
        ctx.lineWidth = 2;
        ctx.strokeStyle = Material.color(Material.DeepOrange)//'#7CC1CC';
        ctx.stroke();
        ctx.strokeStyle="#7CC1CC";


        var nObjects = 16
        var degFinal = 360 / nObjects
        var theColor = Material.color(Material.DeepOrange);
        var arrColors = getDegraded("#212121",theColor.toString(), nObjects)//"#52484d",  nObjects);//"#7CC1CC" cyan oscuro, "#52484d" cyan,
        for(var i=0;i<nObjects;i++) {
            var start_x = centerX+Math.round((centerX-radioCirculo*1.8)*Math.cos(degFinal*i*Math.PI/180));
            var start_y = centerY+Math.round((centerY-radioCirculo*1.8)*Math.sin(degFinal*i*Math.PI/180));
            ctx.beginPath();
            var rMiniC =Math.floor(radioCirculo*0.08)
            ctx.arc(start_x,start_y,1,0,Math.PI*2,true);
            ctx.fillStyle = arrColors[i];//'#7CC1CC';
            ctx.fill();
            ctx.lineWidth = lineCircle*2;
            ctx.strokeStyle = arrColors[i]; //'#7CC1CC';
            ctx.stroke();
        }
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
