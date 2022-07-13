import * as d3 from "d3";

import download from './../download/donwload.js';

import SaveService from './saveService';


class Colorizer {
    constructor(urlProductSVG, urlColorSVG, i18n) {
        this.i18n = i18n;
        this.SaveService = new SaveService();


        this.symmetrical = true;
        this.vProfile = false;
        this.activeColor = undefined;

        this.productHash = window.location.href.hashCode();

        //this._clearSvg();

        this.productSVGElement = document.getElementById("productSVG");
        this.productSVGElement.onload = this.init.bind(this);

        this.colorSVGElement = document.getElementById("colorSVG");
        this.colorSVGElement.onload = this.initColor.bind(this);

        fetch(urlProductSVG)
            .then(r => r.blob())
            .then(b => this.productSVGElement.data = URL.createObjectURL(b))
            .then(() => fetch(urlColorSVG))
            .then(r => r.blob())
            .then(b => this.colorSVGElement.data = URL.createObjectURL(b))
            .then(() => d3.select('#spiderkites-colorizer').transition().style('opacity', '1'))
            .catch(e => console.log(e));
    }

    init(){
        this.initProduct(true);
        this.initButtons();
    }

    initProduct(firstLoad) {
        this.productSvg = firstLoad ? d3.select(this.productSVGElement.contentDocument).select('svg') : d3.select('#product svg');
        this.productParts = this.productSvg.selectAll("g polygon");

        const that = this;

        this.productSvg.on('click', function () {
            var mousePosition = d3.mouse(this);

            that.productParts.each(function () {
                const isDisabled = that._isDisabled(this.parentNode);
                const isVProfile = that._isVProfile(this.parentNode);
                if (!isDisabled && !isVProfile && !that.vProfile) {
                    const part = d3.select(this);
                    const polygon = that._getPolygonFromElement(part);
                    const isInside = that._inside(mousePosition, polygon);

                    if (isInside && that.activeColor) {
                        if (that.symmetrical) {
                            const parent = d3.select(this.parentNode);
                            parent.selectAll('polygon').transition().style("fill", that.activeColor.style('fill')).style('opacity', that.activeColor.style('opacity'));
                        } else {
                            part.transition().style("fill", that.activeColor.style('fill')).style('opacity', that.activeColor.style('opacity'));
                        }
                    }
                }
            })
        })
    }


    initColor() {
        const that = this;
        //var obj = document.getElementById("colorSVG");

        d3.select(this.colorSVGElement.contentDocument).selectAll("rect")
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

                if (that.vProfile) {
                    that.colorVProfile();
                }
            })
    }

    colorVProfile() {
        const that = this;
        this.productParts.each(function () {
            const part = d3.select(this);
            const isVProfile = d3.select(this.parentNode).attr('id') === 'vProfile'
            if (isVProfile) {
                part.transition().style("fill", that.activeColor.style('fill'));
            }
        })
    }

    initButtons() {
        const that = this;

        // Clear Button
        d3.select('#clear-btn').on('click', () => {
            that._clearSvg()
        });

        // Download Button
        d3.select('#download-btn').on('click', () => {
            download("kite.svg", this.productSvg.node().outerHTML);
        });

        //Save Button
        d3.select('#save-btn').on('click', () => {
            this.SaveService.setItem(this.productHash, this.productSvg.node().outerHTML);
            alert(this.i18n.translate('SUCCESS_SAVE_DIALOG'));
        });

        //Load Button
        d3.select('#load-btn').on('click', () => {
            const item = this.SaveService.getItem(this.productHash);
            if (item) {
                if (confirm(this.i18n.translate('CONFIRM_DIALOG'))) {
                    this.loadSvg(item);
                }
            } else {
                alert(this.i18n.translate('NO_ITEM_FOUND_DIALOG'));
            }
        });

        // Symetrical Checkbox
        d3.select("#symmetrical-checkbox").on("change", () => {
            this.symmetrical = !this.symmetrical;
        });

        const hasVProfile = this.productSvg.select('#vProfile').empty();
        if (!hasVProfile) {

            d3.select("#show-vprofile-checkbox").style('display', 'initial');

            d3.select("#vprofile-checkbox").on("change", () => {
                this.vProfile = !this.vProfile;
            });
        }
    }

    loadSvg(svg) {
        this._destroyListener();
        d3.select("#product div").html(svg);
        this.initProduct(false);
    }

    _clearSvg() {
        const that = this;
        this.productParts.each(function () {
            const isDisabled = that._isDisabled(this.parentNode);
            const isVProfile = that._isVProfile(this.parentNode);
            if (!isDisabled && !isVProfile) {
                const part = d3.select(this);
                part.transition().style("fill", 'rgb(255, 255, 255)').style('opacity', 0.8);
            } else if (isVProfile) {
                const part = d3.select(this);
                part.transition().attr('style', undefined);
            }
        })

    }

    _isDisabled(node) {
        const nodeId = d3.select(node).attr('id');
        return nodeId === 'disabled';
    }

    _isVProfile(node) {
        const nodeId = d3.select(node).attr('id');
        return nodeId === 'vProfile';
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