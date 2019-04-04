import QtQuick 2.0
import "../js/Utils/Utils.js" as Utils
import "../js/Grid/Grid.js" as Grid
import "../js/Square/Square.js" as Square

Canvas {
    property variant utils: ({})
    property variant grid: ({})
    property variant square: ({})
    property real angle
    property int fps

    id: canvasMenu
    width: parent.width
    height: parent.height
    smooth: true
    //rotation: 270
    Timer {
      id: repaintTimer
      running: false
      interval: 0
      onTriggered: {
        angle += 0.01
        canvasMenu.requestPaint()
      }
    }

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: {
        console.log(fps)
        fps = 0
      }
    }
    onPaint: {

        var ctx     = getContext("2d");
        ctx.save();
        var centerX = canvasMenu.width/2;
        var centerY = canvasMenu.height/2
        var angle = 0;
        var speed = .025;
        var hue = 0;
        var hueRange = 60;
        var hueChange = 1;
        var squares1 = [];


        var oUtils = new Utils.Utils();
       /* canvasMenu.square = new Square.Square(ctx ,oUtils,
                                              1200,centerX,centerX,angle, squares1);
        canvasMenu.grid = new Grid.Grid(ctx, canvasMenu.square,
                                        angle, parent.width, parent.height, hue, speed,hueChange);
*/

        var squaresCount = 1200;
        var slice = Math.PI * 2 / squaresCount;

function Square1() {
        this.px = centerX;
        this.py = centerY;
        this.width = .5;
        this.height = .5;
        this.vx = .25
        this.vy = .25;
        this.radians = 0;
        this.color = '#1ABC9C';
        this.offset = {
          px: oUtils.randomize(0, 25 + Math.cos(angle) * 2.15),
          py: oUtils.randomize(0, 25 + Math.sin(angle) * 2.15)
        };
}

        ctx.fillStyle = 'white';
        ctx.font = "100px ubuntu";
        ctx.strokeStyle = 'white';

        ctx.fillStyle = "rgba(225,150,150,0)";
        ctx.fillRect(0,0, width, height);


        var frame = undefined
animate ();
initSquare();

        function init () {
            animate();
        };

        function clearCanvas () {
            ctx.fillStyle = 'rgba( 0, 0, 0, ' + ( .2 + Math.cos( angle ) * .15 ) + ' )';
            ctx.fillRect( 0, 0, width, height );
        };
        function animate () {
            var _this = this;
            //  frame = canvasMenu.requestAnimationFrame( animate(_this) );
            update();
            draw();
        };
        function update () {
            angle += speed;
            hue += hueChange;
        };
        function draw () {
            clearCanvas();
            canvasMenu.square.particles();
        };

        function initSquare() {
              for (var i = 0; i < squaresCount; i++) {
                var square = new Square();
                square.px = 10 + Math.cos(angle) * square.offset.px;
                square.py = 10 + Math.sin(angle) * square.offset.py;
                square.radians = Math.atan2(square.py - square.offset.py, square.px - square.offset.px);
                squares1.push(square);
                angle = i * slice;
                  this.grid = grid
              }
            };
        function drawSquare(square, ctx) {
              ctx.save();
              ctx.beginPath();
              ctx.globalCompositeOperation = 'lighter';
              ctx.translate(centerX, centerY);
              ctx.rotate(angle * square.radians);
              ctx.fillStyle = square.color;
              ctx.fillRect(centerX / 4 - square.px, centerY / 4 - square.py, square.width, square.height);
              ctx.globalCompositeOperation = 'source-over';
              ctx.closePath();
              ctx.restore();
            }
        function particles() {
              for (var i = 0; i < squares1.length; i++) {
                var square1 = squares1[i];
                // square1:motion
                square1.px += square1.vx;
                square1.py += square1.vy;
                square1.px = centerX / 2 + Math.cos(angle) * square1.offset.py;
                square1.py = centerY / 2 + Math.cos(angle) * square1.offset.py;

                this.drawSquare(square1, this.grid.ctx);
              }
            }


        ctx.restore();
        fps += 1
        repaintTimer.start()
    }
    //  RotationAnimation on rotation { from: 360; to: 0; duration: 4000; running: true; loops: Animation.Infinite }
    function getWidth(item) { return item.width < item.height ? item.width : item.height }
    MouseArea {
        anchors.fill: parent
        onClicked: function () {
            canvasMenu.requestPaint()
        }
    }
}

