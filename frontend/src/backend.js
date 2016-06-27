import JwtInterface from './JwtInterface'
import Websocket from './Websocket'
import WebsocketDispatcher from './WebsocketDispatcher'
import store from './store'
import {
  dispatchThingsSet,
  dispatchUsersOwnId,
  dispatchUsersSet,
} from './store/actions'

export default {

  send: function (message, args, responseHandler) {
    let id = WebsocketDispatcher.addResponseHandler(responseHandler)

    Websocket.transmit(
      JSON.stringify({
        id: id,
        jwt: JwtInterface.state.jwt,
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
        dispatchThingsSet(store, response)
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

  thingDelete: function (id) {
    this.send(
      '/things/delete',
      { id: id },
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

  usersLoad: function () {
    this.send(
      '/users',
      {},
      function (response) {
        dispatchUsersSet(store, response)
      }
    )
  },

  usersOwnId: function () {
    this.send(
      '/users/own-id',
      {},
      function (response) {
        dispatchUsersOwnId(store, response)
      }
    )
  },

}
