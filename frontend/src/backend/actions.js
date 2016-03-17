/* import JwtInterface from '../JwtInterface' */
import Websocket from '../Websocket'
import WebsocketDispatcher from '../WebsocketDispatcher'

function send (message, args, responseHandler) {
  let id = WebsocketDispatcher.addResponseHandler(responseHandler)

  Websocket.transmit(
    JSON.stringify({
      id: id,
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
    function (response) {
      dispatch('THING_CREATE', response)
    }
  )
}
