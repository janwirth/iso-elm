const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 8080 });
const {Elm} = require('./src/Server.js')
console.log(Elm)

const app = Elm.Server.init()


wss.on('connection', function connection(ws, req) {
  const id = req.headers['sec-websocket-key']
  console.log(id)
  app.ports.connect.send(id)
  ws.on('message', function incoming(message) {
    app.ports.receive.send([id, message])
  });
  ws.send('something');
});
