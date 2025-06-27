import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { service } from "@ember/service";
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

  willDestroy() {
    super.willDestroy(...arguments);
    clearInterval(this.interval);
  }

  startRotating() {
    this.interval = setInterval(() => {
      this.bannerIndex = (this.bannerIndex + 1) % this.text.length;
    }, settings.banner_delay);
  }

  get shouldRender() {
    if (!this.currentUser) {
      return true;
    }
    const exemptGroups = settings.banner_exempt_groups
      .split("|")
      .map((id) => parseInt(id, 10));
    const includeGroups = settings.banner_include_groups
      .split("|")
      .map((id) => parseInt(id, 10));
    const userGroups = this.currentUser.groups.map((group) => group.id);
    const isExempt = userGroups.some((group) => exemptGroups.includes(group));
    const isIncluded = userGroups.some((group) =>
      includeGroups.includes(group)
    );

    if (exemptGroups.length > 0) {
      return !isExempt;
    } else if (includeGroups.length > 0) {
      return isIncluded;
    } else {
      return true;
    }
  }

  get currentBannerText() {
    return this.text[this.bannerIndex];
  }

  <template>
    {{#if this.shouldRender}}
      <div class="rotating-banner">
        <div>{{htmlSafe this.currentBannerText}}</div>
      </div>
    {{/if}}
  </template>
}
