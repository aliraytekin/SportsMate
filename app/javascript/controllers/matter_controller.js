import { Controller } from "@hotwired/stimulus"
import Matter from "matter-js"

export default class extends Controller {
  static targets = ["world"]

  connect() {
    const {
      Engine,
      Render,
      Runner,
      World,
      Bodies,
      Events
    } = Matter;

    const engine = Engine.create();
    const world = engine.world;

    const canvas = this.worldTarget

    const width = canvas.clientWidth;
    const height = canvas.clientHeight;

    const render = Render.create({
      canvas: canvas,
      engine: engine,
      options: {
        width,
        height,
        wireframes: false,
        background: "#F8FAFC",
      }
    });

    Render.run(render);
    Runner.run(Runner.create(), engine);


    const radius = 15;
    const imageUrls = [
      "/images/football.png",
      "/images/swimming.png",
      "/images/baseball.png",
      "/images/basketball.png",
      "/images/boxing.png",
      "/images/climbing.png",
      "/images/cycling.png",
      "/images/golf.png",
      "/images/judo.png",
      "/images/kickboxing.png",
      "/images/rugby.png",
      "/images/running.png",
      "/images/surfing.png",
      "/images/table-tennis.png",
      "/images/tennis.png",
      "/images/volleyball.png",
      "/images/yoga.png"
    ]

    for (let i = 0; i < 14; i++) {
      const img = imageUrls[i % imageUrls.length];
      const circle = Bodies.circle(
        Math.random() * width, -radius, radius, {
          restitution: 0.9,
          render: {
            sprite: {
              texture: img,
              xScale: 0.0586,
              yScale: 0.0586
            }
          }
        }
      )
      World.add(world, circle);
    }



    const ground = Bodies.rectangle(width / 2, height + 50, width * 2, 100, {
      isStatic: true,
      render: { visible: false }
    });
    World.add(world, ground);
  }
}
