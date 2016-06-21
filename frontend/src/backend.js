import JwtInterface from './JwtInterface'
import Websocket from './Websocket'
import WebsocketDispatcher from './WebsocketDispatcher'
import store from './store'

export default {

  send: function (message, args, responseHandler) {
    let id = WebsocketDispatcher.addResponseHandler(responseHandler)

    Websocket.transmit(
      JSON.stringify({
        id: id,
        jwt: JwtInterface.getters.jwt(),
        message: message,
        args: args,
      })
    )
  },

  thingsLoad: function () {
    this.send(
      '/things',
      {},
      function (response) {
        store.actions.dispatchThingsSet(response)
      }
    )
  },

  thingCreate: function (name, description) {
    this.send(
      '/things/create',
      {
        name: name,
        description: description,
      },
      function (response) { }
    )
  },

  userCreate: function (username, password, onSuccess) {
    this.send(
      '/users/create',
      {
        username: username,
        password: password,
      },
      onSuccess
    )
  },

  userAuthenticationCreate: function (username, password, onSuccess) {
    this.send(
      '/users/authentications/create',
      {
        username: username,
        password: password,
      },
      onSuccess
    )
  },

}
