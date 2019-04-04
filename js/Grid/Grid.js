
function Grid(ctx,square, angle, width, height, hue,speed,hueChange){
    this.width = width
    this.height = height
    this.ctx = ctx

    this.frame = undefined;


    this.init = function init (ctx) {
        this.animate();
    };

    this.clearCanvas = function clearCanvas () {
        this.ctx.fillStyle = 'rgba( 0, 0, 0, ' + ( .2 + Math.cos( angle ) * .15 ) + ' )';
        this.ctx.fillRect( 0, 0, this.width, this.height );
    };
    this.animate = function animate () {
        this.frame = requestAnimationFrame( this.animate.bind( this ) );
        this.update();
        this.draw();
    };
    this.update = function update () {
        angle += speed;
        hue += hueChange;
    };
    this.draw = function draw () {
        this.clearCanvas();
        //square.particles();
    };
}
