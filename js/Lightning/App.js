
var App = (function() {
  function App() {
    this.tick = 0;
    this.bolts = [];
    this.initCanvas();
    this.render();
  }
  return App;
})();

App.prototype.initCanvas = function() {
  this.canvas = document.getElementById("canvas");
  this.ctx = this.canvas.getContext("2d");
  this.dimensions = new vec2();
  this.center = new vec2();
  this.resize();
};

App.prototype.resize = function() {
  this.canvas.width = this.dimensions.x = window.innerWidth;
  this.canvas.height = this.dimensions.y = window.innerHeight;
  this.center.x = this.dimensions.x * 0.5;
  this.center.y = this.dimensions.y * 0.5;
};

App.prototype.draw = function() {
  this.ctx.fillStyle = "rgba(0,0,0,0.5)";
  this.ctx.fillRect(0, 0, this.dimensions.x, this.dimensions.y);
  this.ctx.save();
  this.ctx.shadowColor = "rgba(165,215,255,0.9)";
  this.ctx.shadowBlur = 20;
  if (this.bolts.length > 0) {
    for (var i = this.bolts.length - 1; i >= 0; i--) {
      var bolt = this.bolts[i];
      bolt.update();
      for (var j = 0, len = bolt.segments.length; j < len; j++) {
        var segment = bolt.segments[j];
        this.ctx.beginPath();
        this.ctx.strokeStyle =
          "rgba(165,215,255," + bolt.alpha.toString() + ")";
        this.ctx.lineWidth = segment.width;
        this.ctx.moveTo(segment.start.x, segment.start.y);
        this.ctx.lineTo(segment.end.x, segment.end.y);
        this.ctx.stroke();
        this.ctx.closePath();
      }
      if (bolt.life > bolt.ttl) this.bolts.splice(i, 1);
    }
  }
  this.ctx.fill();
  this.ctx.restore();
};

App.prototype.render = function() {
  var self = this,
    randomInt = Math.round(Math.random() * 60);
  self.tick++;
  if (self.tick % randomInt === 0) {
    for (var i = 0; i < 3; i++) {
      self.bolts.push(
        new Lightning(
          new Vec2(Math.round(Math.random() * this.canvas.width), 0),
          new Vec2(Math.round(Math.random() * this.canvas.width), this.canvas.height),
          5
        )
      );
    }
  }
  self.draw();
  window.requestAnimationFrame(self.render.bind(self));
};
