import { apiInitializer } from "discourse/lib/api";
import RotatingBanner from "../components/rotating-banner";

export default apiInitializer((api) => {
  // Your code here (uncomment api above to use it)
  api.renderInOutlet(settings.banner_outlet, RotatingBanner);
});
