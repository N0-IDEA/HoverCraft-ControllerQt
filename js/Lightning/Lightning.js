

var Lightning =
  function Lightning(center, end, iterations) {
    this.start = new Vector2(center.x, center.y);
    this.end = new Vector2(end.x, end.y);
    this.iterations = iterations || 5;
    this.life = 0;
    this.ttl = 1;

      this.update = function () {
        this.alpha = (this.ttl - this.life) / this.ttl;

        for (var i = this.segments.length - 1; i > 1; i--) {
          var segment = this.segments[i];
          segment.start.addRandom(0.8);
        }
        this.life++;
      };

      this.generateSegments = function () {
        this.segments = [];
        this.segments.push(new Segment(this.start, this.end));
        this.branches = Math.round(1 + Math.random() * 2);

        for (var i = 0; i < this.iterations; i++) {
          for (var j = this.segments.length; j > 0; j--) {
            var segmentWidth = 1,
                oldSegment = this.segments[j - 1],
                start = oldSegment.start,
                end = oldSegment.end,
                mid = start.midpoint(end),
                angle = (start.angleTo(end, "deg") - 90) * Math.PI / 180,
                offset = (15 - Math.random() * 30) / (i + 1) * (start.distanceTo(end) * 0.025);
            mid.addScalarX(Math.cos(angle) * offset);
            mid.addScalarY(Math.sin(angle) * offset);
            var newSegment1 = new Segment(start, mid, segmentWidth);
            var newSegment2 = new Segment(mid, end, segmentWidth);

            this.segments.splice(j - 1, 1);
            this.segments.push(newSegment1);
            this.segments.push(newSegment2);

            if (i < this.branches) {
              var branchAngle = (start.angleTo(end, "deg") + (45 - Math.random() * 90)) * Math.PI / 180,
              branchStart = mid,
              branchEnd = new Vector2(
              branchStart.x + Math.cos(branchAngle) * branchStart.distanceTo(end) * 0.85, branchStart.y + Math.sin(branchAngle) * branchStart.distanceTo(end) * 0.85),
                  branch = new Segment(branchStart, branchEnd, 0.5);
              this.segments.push(branch);
            }
          }
        }
      };
      this.generateSegments();
  };

Qt.include("./Segment.js");
Qt.include("./Vec2.js");
