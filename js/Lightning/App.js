var App = function App(ctx, width, height,repaintTimer) {
            this.tick = 0;
            this.bolts = [];
            this.initCanvas = function(ctx, width, height) {
                this.ctx = ctx
                this.dimensions = new Vector2();
                this.center = new Vector2();
                this.resize(width, height);
            };
            this.resize = function(width, height) {
                this.dimensions.x = width
                this.dimensions.y =  height
                this.center.x = this.dimensions.x * 0.5;
                this.center.y = this.dimensions.y * 0.5;
            };
            this.draw = function() {
                this.ctx.fillStyle = "rgba(0,0,0,0.5)";
                this.ctx.fillRect(0, 0, this.dimensions.x, this.dimensions.y);
                this.ctx.save();
                this.ctx.shadowColor = "rgba(165,215,255,0.9)";
                this.ctx.shadowBlur = 20;
                if (this.bolts.length > 0) {
                    for (var i = this.bolts.length - 1; i >= 0; i--) {
                        var bolt = this.bolts[i];
                        bolt.update();
                        var segment
                        for (var j = 0, len = bolt.segments.length; j < len; j++) {
                            segment = bolt.segments[j];

                            this.ctx.beginPath();
                            this.ctx.strokeStyle = "rgba(165,215,255," + bolt.alpha.toString() + ")";
                            this.ctx.lineWidth = segment.width;
                            this.ctx.moveTo(Math.round(segment.start.x), Math.round( segment.start.y));
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
            this.render = function(repaintTimer){
                var self = this,
                randomInt = Math.round(Math.random() * 60);
                self.tick++;
                console.log(self.tick)
                if (self.tick % randomInt === 0) {
                    for (var i = 0; i < 3; i++) {
                        var ligthningTemp = new Lightning.Lightning(
                                    new Vector2(self.center.x, 0),
                                    new Vector2(Math.round(Math.random() * this.dimensions.x), this.dimensions.y),
                                    5
                                    )
                        console.log(ligthningTemp)
                        self.bolts.push( ligthningTemp );
                    }
                }
                self.draw();
              //  repaintTimer.start();
            };
            this.initCanvas(ctx, width, height);
            this.render(repaintTimer);
        }
Qt.include("./Vec2.js");
Qt.include("./Lightning.js ");
