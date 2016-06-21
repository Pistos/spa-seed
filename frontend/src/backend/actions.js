import JwtInterface from '../JwtInterface'
import Websocket from '../Websocket'
import WebsocketDispatcher from '../WebsocketDispatcher'

function send (message, args, responseHandler) {
  let id = WebsocketDispatcher.addResponseHandler(responseHandler)

  Websocket.transmit(
    JSON.stringify({
      id: id,
      jwt: JwtInterface.getters.jwt(),
      message: message,
      args: args,
    })
  )
}

export const thingsLoad = ({dispatch, state}) => {
  send(
    '/things',
    {},
    function (response) {
      dispatch('THINGS_SET', response)
    }
  )
}

export const thingCreate = ({dispatch, state}, name, description) => {
  send(
    '/things/create',
    {
      name: name,
      description: description,
    },
    function (response) { }
  )
}

// TODO: change `response` to `args`
export const dispatchThingCreate = ({dispatch, state}, response) => {
  dispatch('THING_CREATE', response)
}

// TODO: change `response` to `args`
export const dispatchThingUpdate = ({dispatch, state}, response) => {
  dispatch('THING_UPDATE', response)
}

export const userCreate = ({dispatch, state}, username, password, onSuccess) => {
  send(
    '/users/create',
    {
      username: username,
      password: password,
    },
    onSuccess
  )
}

export const userAuthenticationCreate = ({dispatch, state}, username, password, onSuccess) => {
  send(
    '/users/authentications/create',
    {
      username: username,
      password: password,
    },
    onSuccess
  )
}

