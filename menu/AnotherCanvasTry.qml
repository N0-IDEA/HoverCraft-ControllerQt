import QtQuick 2.0

Canvas {
  id: canvasMenu
  width: 200
  height: 200
  property real angle
  property int fps

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
    var ctx = getContext("2d")
    ctx.save()
      ctx.strokeStyle = "white"
    ctx.clearRect(0, 0, width, height)
    ctx.moveTo(100, 100)
    ctx.translate(100,100)
    ctx.rotate(angle)
    ctx.beginPath()
    ctx.lineTo(40, 10)
    ctx.lineTo(40, 40)
    ctx.lineTo(10, 40)
    ctx.lineTo(10, 10)
    ctx.closePath()
    ctx.stroke()
    ctx.restore()
    fps += 1
    repaintTimer.start()
  }
}
