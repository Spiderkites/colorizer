export default class SaveService {
    constructor() { }

    setItem(key, item) {
        localStorage.setItem(key, item);
    }

    getItem(key) {
        return localStorage.getItem(key);
    }
}