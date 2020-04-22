import * as d3 from "d3";

import download from './../download/donwload.js';

import SaveService from './saveService';

class Colorizer {
    constructor(production) {
        this.SaveService = new SaveService();

        this.initProduct();

        this.symmetrical = false;
        this.activeColor = undefined;


        if (!production) {
            this.cleanUpProductSvg();
        }

        this.initColor();
        this.initButtons();
    }

    cleanUpProductSvg() {
        const productStyle = this.productSvg.select('defs style');
        productStyle.html(productStyle.html().replace('.cls-1', 'g > polygon').replace('fill:none', 'fill: rgb(255, 255, 255)'))
        this.productSvg.selectAll(".cls-1").classed('cls-1', false);
    }



    initProduct() {
        this.productSvg = d3.select('#product svg');
        this.productParts = this.productSvg.selectAll("g polygon");
        this.productUUID = d3.select('#product').attr('uuid');

        const that = this;

        this.productSvg.on('click', function () {
            var mousePosition = d3.mouse(this);

            that.productParts.each(function () {
                const part = d3.select(this);
                const polygon = that._getPolygonFromElement(part);
                const isInside = that._inside(mousePosition, polygon);

                if (isInside && that.activeColor) {
                    if (that.symmetrical) {
                        const parent = d3.select(this.parentNode);
                        parent.selectAll('polygon').transition().style("fill", that.activeColor.style('fill'));
                    } else {
                        part.transition().style("fill", that.activeColor.style('fill'));
                    }
                }
            })
        })
    }

    initColor() {
        const that = this;

        d3.selectAll("#color-palet rect")
            .style('cursor', 'pointer')
            .on('click', function () {
                const color = d3.select(this);
                if (that.activeColor) {
                    that.activeColor.style('stroke', null);
                    that.activeColor.style('stroke-width', null);
                }

                that.activeColor = color;

                that.activeColor.style('stroke', "#474747");
                that.activeColor.style('stroke-width', "1.5px");
            })
    }

    initButtons() {
        // Clear Button
        d3.select('#clear-btn').on('click', () => {
            this.productParts.each(function () {
                const part = d3.select(this);
                part.transition().style("fill", 'rgb(255, 255, 255)');

            })
        });

        // Download Button
        d3.select('#download-btn').on('click', () => {
            download("kite.svg", this.productSvg.node().outerHTML);
        });

        //Save Button
        d3.select('#save-btn').on('click', () => {
            this.SaveService.setItem(this.productUUID, this.productSvg.node().outerHTML);
        });

        //Load Button
        d3.select('#load-btn').on('click', () => {
            this.loadSvg(this.SaveService.getItem(this.productUUID));
        });

        // Symetrical Checkbox
        d3.select("#symmetrical-checkbox").on("change", () => {
            this.symmetrical = !this.symmetrical;
        });
    }

    loadSvg(svg) {
        this._destroyListener();
        d3.select("#product div").html(svg);
        this.initProduct();
    }

    _destroyListener() {
        this.productSvg.on('click', null);
    }

    _inside(point, vs) {
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

    _getPolygonFromElement(element) {
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
}

export default Colorizer;