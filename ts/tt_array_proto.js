"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var hongx = { id: 1, name: 'Hing' };
var kimx = { id: 2, name: 'Kim' };
var leex = { id: 3, name: 'Lee' };
var users = [hongx, leex, kimx];
Array.prototype.filterBy = function (prop, value, isIncludes) {
    if (isIncludes === void 0) { isIncludes = false; }
    return this.filter(function (a) {
        if (isIncludes)
            return a[prop].includes(value);
        else
            return a[prop] === value;
    });
};
console.log(users.filterBy('id', 2)); // [kim]);
console.log(users.filterBy('name', 'i', true)); // [kim]
Array.prototype.mapBy = function (prop) {
    return this.map(function (a) { return a[prop]; });
};
console.log(users.mapBy('id')); // [1, 3, 2];
console.log(users.mapBy('name')); // ['Hong', 'Lee', 'Kim']);
