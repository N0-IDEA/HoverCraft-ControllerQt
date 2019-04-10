Qt.include("./Vec2.js");

var Segment = function Segment(start, end, width) {
      this.start = start || new Vector2();
      this.end = end || new Vector2();
      this.width = width;
    };
