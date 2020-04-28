import * as d3 from "d3";

import de from "./de";
import en from "./en";

const translations = ['download-btn-text', 'save-btn-text', 'load-btn-text', 'clear-btn-text', 'symmetrical-checkbox-text'];

export default class i18n {
    constructor() {
        this.de = de;
        this.en = en;
        this.lang = document.documentElement ? document.documentElement.lang : 'de';

        translations.forEach(this.translateForId.bind(this));
    }

    translateForId(id) {
        try {
            const element = d3.select(`#${id}`);
            const key = element.text().trim();

            const translation = this.translate(key);

            if (translation) {
                element.text(translation);
            }
        } catch (e) {
            console.error(e);
        }

    }

    translate(key) {

        return this[this.lang][key];
    }
}