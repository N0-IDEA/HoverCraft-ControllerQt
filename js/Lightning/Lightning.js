Qt.include("./Segment.js");

var Lightning = function () {
  function Lightning(center, end, iterations) {
    this.start = new vec2(center.x, center.y);
    this.end = new vec2(end.x, end.y);
    this.iterations = iterations || 5;
    this.life = 0;
    this.ttl = 10;
    this.generateSegments();
  }

  return Lightning;
}();

Lightning.prototype.update = function () {
  this.alpha = (this.ttl - this.life) / this.ttl;

  for (var i = this.segments.length - 1; i > 1; i--) {
    var segment = this.segments[i];
    segment.start.addRandom(0.8);
  }

  this.life++;
};

Lightning.prototype.generateSegments = function () {
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
      var newSegment1 = new Segment(start, mid, segmentWidth),
          //create two new segments to replace current segment
      newSegment2 = new Segment(mid, end, segmentWidth);
      this.segments.splice(j - 1, 1); //remove the old segment

      this.segments.push(newSegment1); //replace the old segment

      this.segments.push(newSegment2);

      if (i < this.branches) {
        //add branches until i is greater than number of branches
        var branchAngle = (start.angleTo(end, "deg") + (45 - Math.random() * 90)) * Math.PI / 180,
            //calculate current angle then offset by random amount between -45 and 45 (degrees) then convert to radians
        branchStart = mid,
            //start at midpoint
        branchEnd = new Vec2( //offset branch end along calculated angle to length of current segment
        branchStart.x + Math.cos(branchAngle) * branchStart.distanceTo(end) * 0.85, branchStart.y + Math.sin(branchAngle) * branchStart.distanceTo(end) * 0.85),
            branch = new Segment(branchStart, branchEnd, 0.5);
        this.segments.push(branch);
      }
    }
  }
};
