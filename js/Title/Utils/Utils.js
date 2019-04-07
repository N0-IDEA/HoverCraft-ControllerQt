function Utils () {
    this.randomize = function randomize ( min, max ) {
        return Math.random() * ( max - min ) + min;
    };
    this.distance = function distance ( nodeA, nodeB ) {
        var dx = nodeB.px - nodeA.px;
        var dy = nodeB.py - nodeA.py;
        var dist = Math.sqrt( dx * dx + dy * dy );
        return dist;
    };
}
