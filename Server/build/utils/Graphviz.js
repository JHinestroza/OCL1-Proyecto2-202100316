"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CEdge = exports.CNode = exports.CDigraph = void 0;
const ts_graphviz_1 = require("ts-graphviz");
const graphviz_cli_renderer_1 = require("@diagrams-ts/graphviz-cli-renderer");
const fs = require('fs');
class CDigraph extends ts_graphviz_1.Digraph {
    constructor(label) {
        super('G', {
            [ts_graphviz_1.attribute.label]: label,
        });
    }
    generate() {
        return __awaiter(this, void 0, void 0, function* () {
            const render = (0, graphviz_cli_renderer_1.CliRenderer)({ outputFile: "./AST.pdf", format: "pdf" });
            yield (() => __awaiter(this, void 0, void 0, function* () {
                try {
                    yield render((0, ts_graphviz_1.toDot)(this));
                }
                catch (error) {
                    console.log(error);
                }
            }))();
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
