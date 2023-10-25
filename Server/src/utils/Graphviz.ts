import { Digraph, Node, Edge, EdgeTargetTuple, attribute, toDot } from 'ts-graphviz';
import { CliRenderer } from "@diagrams-ts/graphviz-cli-renderer";
const fs = require('fs');

export class CDigraph extends Digraph {
  constructor(label: string) {
    super('G', {
      [attribute.label]: label,
    });
  }


}
export class CNode extends Node {
  constructor(id: number, label: string) {
    super(`node${id}`, {
      [attribute.label]: label
    });
  }
}

export class CEdge extends Edge {
  constructor(targets: EdgeTargetTuple, label: string) {
    super(targets, {
      [attribute.label]: label
    });
  }
}
