function Square(ctx, utils, nSquares, xCenter, yCenter, angle, squares1) {
    var squaresCount = nSquares;
    var slice = Math.PI * 2 / squaresCount;
    this.utils = utils
    this.px = xCenter;
    this.py = yCenter;
    this.width = .5;
    this.height = .5;
    this.vx = .25
    this.vy = .25;
    this.radians = 0;
    this.color = '#1ABC9C';
    this.offset = {
      px: this.utils.randomize(0, 25 + Math.cos(angle) * 2.15),
      py: this.utils.randomize(0, 25 + Math.sin(angle) * 2.15)
    };
    this.init = function init(ctx, utils, nSquares, xCenter, yCenter, angle, squares1) {
      for (var i = 0; i < squaresCount; i++) {
        var square = new Square(ctx, utils, nSquares, xCenter, yCenter, angle, squares1);
        square.px = 10 + Math.cos(angle) * square.offset.px;
        square.py = 10 + Math.sin(angle) * square.offset.py;
        square.radians = Math.atan2(square.py - square.offset.py, square.px - square.offset.px);
        squares1.push(square);
        angle = i * slice;
          this.grid = grid
      }
    };
    this.draw = function draw(square, ctx) {
      ctx.save();
      ctx.beginPath();
      ctx.globalCompositeOperation = 'lighter';
      ctx.translate(xCenter, yCenter);
      ctx.rotate(angle * square.radians);
      ctx.fillStyle = square.color;
      ctx.fillRect(xCenter / 4 - square.px, yCenter / 4 - square.py, square.width, square.height);
      ctx.globalCompositeOperation = 'source-over';
      ctx.closePath();
      ctx.restore();
    };
    this.particles = function particles() {
      for (var i = 0; i < squares1.length; i++) {
        var square1 = squares1[i];
        // square1:motion
        square1.px += square1.vx;
        square1.py += square1.vy;
        square1.px = xCenter / 2 + Math.cos(angle) * square1.offset.py;
        square1.py = yCenter / 2 + Math.cos(angle) * square1.offset.py;

        this.draw(square1, this.grid.ctx);
      }
    };
  }
