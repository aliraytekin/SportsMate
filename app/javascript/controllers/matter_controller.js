import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="matter"
export default class extends Controller {
  static targets = ["world"]

  connect() {
    const {
      Engine,
      Render,
      Runner,
      World,
      Bodies,
      Body,
      Events,
  } = Matter;

  const engine = Engine.create();
  const world = engine.world;

  const canvas = this.worldTarget;
  const width = window.innerWidth;
  const height = window.innerHeight;

  const render = Render.create({
    canvas: canvas,
    engine: engine,
    options: {
      width: width,
      height: height,
      wireframes: false,
      background: '#f0f0f0',
      },
    });

  Render.run(render);
  Runner.run(Runner.create(), engine);
  }
}
