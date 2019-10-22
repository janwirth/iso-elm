# Iso-Elm
Write elm on client and server

## Concept

### Architecture
The Architecture is inspired by lambdera.

```
type Server =
updateFromClient : ClientId -> MsgFromClient -> BackendModel -> ( Model, Cmd BackendMsg )
```

### Platform
- socket.io as transportation for backend and frontend
- decgen for generating the data interchange

### Development
`npm start`
to
- watch-generate coders
- watch-serve frontend as with create-elm-app
- watch-compile and run backend
  - nodemon

## Next Steps
- Connect using socket.io
