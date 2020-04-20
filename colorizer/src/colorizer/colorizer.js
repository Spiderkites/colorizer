import * as d3 from "d3";

export default function () {

    // temp
    const symmetrical = true;

    /*temp bis neues Template*/
    d3.selectAll('#spiderkites-colorizer > div').style('margin', '1rem');

    const kiteSvg = d3.select('#kite svg');

    // cleanup svg
    const kiteStyle = kiteSvg.select('defs style');
    kiteStyle.html(kiteStyle.html().replace('.cls-1', 'g > polygon').replace('fill:none', 'fill: rgb(255, 255, 255)'))
    kiteSvg.selectAll(".cls-1").classed('cls-1', false);


    const parts = kiteSvg.selectAll("g polygon");

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
                if(symmetrical){
                    const parent = d3.select(this.parentNode);
                    parent.selectAll('polygon').style("fill", activeColor.style('fill'));
                } else {
                    part.transition().style("fill", activeColor.style('fill'));

                }
            }
        })
    })

    initButton('#clear-btn', () => {
        parts.each(function () {
            const part = d3.select(this);
            part.transition().style("fill", 'rgb(255, 255, 255)');

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

function initButton(id, fn) {
    d3.select(id).on('click', fn);
}