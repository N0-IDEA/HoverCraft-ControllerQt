
function Grid(){

    this.frame = undefined;


    this.init = function init () {
        this.cvs1 = __D.querySelector( '.js-canvas-1' );
        this.cvs1.width = this.width = APP.config.sizes.width;
        this.cvs1.height = this.height =  APP.config.sizes.height;
        this.cvs1.style.width = this.width + 'px';
        this.cvs1.style.height = this.height + 'px';

        this.ctx1 = this.cvs1.getContext( '2d' );

        this.cvs2 = __D.querySelector( '.js-canvas-2' );
        this.cvs2.width = this.width = APP.config.sizes.width;
        this.cvs2.height = this.height =  APP.config.sizes.height;
        this.cvs2.style.width = this.width + 'px';
        this.cvs2.style.height = this.height + 'px';

        this.ctx2 = this.cvs2.getContext( '2d' );

        this.animate();
    };

    this.clearCanvas = function clearCanvas () {
        this.ctx1.fillStyle = 'rgba( 0, 0, 0, ' + ( .2 + Math.cos( angle ) * .15 ) + ' )';
        this.ctx1.fillRect( 0, 0, this.width, this.height );
        this.ctx2.clearRect( 0, 0, this.width, this.height );
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
    this.draw = function draw (square) {
        this.clearCanvas();
        square.particles();
    };
}
