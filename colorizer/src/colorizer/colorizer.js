import * as d3 from "d3";

export default function () {

    const kiteSvg = d3.select('#kite svg');
    const parts = d3.selectAll(".polygon");

    let activeColor = undefined;

    const colorArray = d3.selectAll("#color-palet rect")
        .style('cursor', 'pointer')
        .on('click', function () {
            const color = d3.select(this);
            if (activeColor) {
                activeColor.style('stroke', null);
                activeColor.style('stroke-width', null);
            }

            activeColor = color;

            activeColor.style('stroke', "#474747");
            activeColor.style('stroke-width', "1.5px");
        })

    kiteSvg.on('click', function () {
        var mousePosition = d3.mouse(this);

        parts.each(function () {
            const part = d3.select(this);
            const polygon = getPolygonFromElement(part);
            const isInside = inside(mousePosition, polygon);

            if (isInside && activeColor) {
                part.transition().style("fill", activeColor.style('fill'));
            }
        })
    })
}

function inside(point, vs) {
    // ray-casting algorithm based on
    // http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html

    var x = point[0], y = point[1];

    var inside = false;
    for (var i = 0, j = vs.length - 1; i < vs.length; j = i++) {
        var xi = vs[i][0], yi = vs[i][1];
        var xj = vs[j][0], yj = vs[j][1];

        var intersect = ((yi > y) != (yj > y))
            && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
        if (intersect) inside = !inside;
    }

    return inside;
};

function getPolygonFromElement(element) {
    const pointsString = element.attr('points');

    if (pointsString) {
        const pointArray = pointsString.split(' ');
        let polygon = [];
        for (let i = 0; i < pointArray.length; i += 2) {
            polygon.push([+pointArray[i], +pointArray[i + 1]]);
        }

        return polygon
    }
}