"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CEdge = exports.CNode = exports.CDigraph = void 0;
const ts_graphviz_1 = require("ts-graphviz");
const fs = require('fs');
class CDigraph extends ts_graphviz_1.Digraph {
    constructor(label) {
        super('G', {
            [ts_graphviz_1.attribute.label]: label,
        });
    }
}
exports.CDigraph = CDigraph;
class CNode extends ts_graphviz_1.Node {
    constructor(id, label) {
        super(`node${id}`, {
            [ts_graphviz_1.attribute.label]: label
        });
    }
}
exports.CNode = CNode;
class CEdge extends ts_graphviz_1.Edge {
    constructor(targets, label) {
        super(targets, {
            [ts_graphviz_1.attribute.label]: label
        });
    }
}
exports.CEdge = CEdge;
