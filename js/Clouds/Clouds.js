function FogParticle (ctx) {
    this.ctx = ctx
    this.canvasWidth = canvasClouds.width
    this.canvasHeight = canvasClouds.height
    this.x = 0
    this.y = 0
    this.xVelocity = 0
    this.yVelocity = 0
    this.setPosition = function setPosition(x, y) {
        this.x = x
        this.y = y
    }
    this.setVelocity = function setVelocity(x, y) {
        this.xVelocity = x
        this.yVelocity = y
    }
    this.render = function render() {
        this.ctx.drawImage(
                 canvasClouds.path,
                 this.x - 400 / 2,
                 this.y - 400 / 2,
                 400,
                 400
                 )
        this.x += this.xVelocity
        this.y += this.yVelocity

        if (this.x >= this.canvasWidth) {
            this.xVelocity = -this.xVelocity
            this.x = this.canvasWidth
        }
        else if (this.x <= 0) {
            this.xVelocity = -this.xVelocity
            this.x = 0
        }
        if (this.y >= this.canvasHeight) {
            this.yVelocity = -this.yVelocity
            this.y = this.canvasHeight
        }
        else if (this.y <= 0) {
            this.yVelocity = -this.yVelocity
            this.y = 0
        }
    }
}

function Fog ( ctx, density , velocity, particle ){
    this.ctx = ctx
    this.canvasWidth = canvasClouds.width
    this.canvasHeight = canvasClouds.height

    this.particleCount = density
    this.maxVelocity = velocity
    this.particle = particle
    this.particles = []
    this._createParticles = function _createParticles() {
        var random = function (min, max) { return Math.random() * (max - min) + min}

        for (var i = 0; i < this.particleCount; i++) {
            var particle = new FogParticle(this.ctx, this.canvasWidth, this.canvasHeight)
            particle.setPosition(
                        random(0, this.canvasWidth),
                        random(0, this.canvasHeight)  )
            particle.setVelocity(
                        random(-this.maxVelocity,this.maxVelocity),
                        random(-this.maxVelocity,this.maxVelocity)  )
            this.particles.push(particle)
        }
    }
    this._render = function _render() { for (var p in this.particles ) { this.particles[p].render() } }

    this._createParticles()
}
