import * as d3 from "d3";

import de from "./de";
import en from "./en";


export default class i18n {
    constructor() {
        this.de = de;
        this.en = en;
        this.lang = document.documentElement ? document.documentElement.lang : 'de';

        this._initStaticText();
    }

    _initStaticText() {

        let that = this;
        d3.selectAll("[translate]").each(function () {
            const element = d3.select(this);
            const key = element.text().trim();

            const translation = that.translate(key);

            if (translation) {
                element.html(translation);
            }
        })
    }

    translate(key) {
        return this[this.lang][key];
    }
}