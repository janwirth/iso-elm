cli:
	elm-app make --optimize src/Server.elm --output=src/Server.js
server:
	elm-app make --debug src/Server.elm --output=src/Server.js
serve:
	nodemon --exec "elm-app make --debug src/Server.elm --output=src/Server.js && node ./server.js"
