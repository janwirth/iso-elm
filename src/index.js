import './main.css';
import {
    Elm
} from './Main.elm';
import registerServiceWorker from './registerServiceWorker';


const seed = crypto.getRandomValues(new Uint32Array(1))[0];

const app = Elm.Main.init({
    node: document.getElementById("root"),
    flags: {
        storage: localStorage,
        seed
    }
});
app.ports.connect.subscribe(connect)
app.ports.send.subscribe(msg => send(msg))

registerServiceWorker();
var send

function connect() {

    const socket = new WebSocket("ws://localhost:8080");
    send = msg => socket.send(JSON.stringify(msg))

    socket.onopen = function(e) {
        console.log(e, socket)
        console.log("[open] Connection established");
        console.log("Sending to server");
        socket.send("My name is John");
    };

    socket.onmessage = function(event) {
        console.log(`[message] Data received from server: ${event.data}`);
    };

    socket.onclose = function(event) {
        if (event.wasClean) {
            console.log(`[close] Connection closed cleanly, code=${event.code} reason=${event.reason}`);
        } else {
            // e.g. server process killed or network down
            // event.code is usually 1006 in this case
            console.log('[close] Connection died');
        }
    };

    socket.onerror = function(error) {
        console.log(`[error] ${error.message}`);
    };
}
