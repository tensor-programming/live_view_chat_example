import { Socket } from "phoenix";
import "phoenix_html";
import LiveSocket from "phoenix_live_view";
import "../css/app.scss";
let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

let ls = new LiveSocket("/live", Socket, {
  params: {
    _csrf_token: csrfToken,
  },
});
ls.connect();
window.liveSocket = liveSocket;
