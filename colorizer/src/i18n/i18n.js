import * as d3 from "d3";

import de from "./de";
import en from "./en";

const translations = ['download-btn-text', 'clear-btn-text', 'symmetrical-checkbox-text'];

export default class i18n {
    constructor() {
        this.de = de;
        this.en = en;
        this.lang = document.documentElement ? document.documentElement.lang : 'de';

        translations.forEach(this.translate.bind(this));
    }

    translate(id) {
        const element = d3.select(`#${id}`);
        const key = element.text();

        element.text(this[this.lang][key]);
    }
}