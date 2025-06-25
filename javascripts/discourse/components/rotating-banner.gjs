import Component from "@glimmer/component";
import { service } from "@ember/service";
import concatClass from "discourse/helpers/concat-class";
import { tracked } from "@glimmer/tracking";
import htmlSafe from "discourse/helpers/html-safe";

export default class RotatingBanner extends Component {
  @service currentUser;
  @tracked bannerIndex = 0;
  @tracked text = settings.banner_text.split("|").map(function (item) {
    return item.trim();
  });

  constructor() {
    super(...arguments);
    this.startRotating();
  }

  startRotating() {
    this.interval = setInterval(() => {
      this.bannerIndex = (this.bannerIndex + 1) % this.text.length;
    }, settings.banner_delay);
  }

  willDestroy() {
    clearInterval(this.interval);
  }

  get currentBannerText() {
    console.log("current text", this.bannerIndex);
    return this.text[this.bannerIndex];
  }

  <template>
    <h1 class="rotating-banner">
      <div>{{htmlSafe this.currentBannerText}}</div>
    </h1>
  </template>
}
