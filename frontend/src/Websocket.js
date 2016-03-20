/*eslint no-undef: 0*/

import WebsocketDispatcher from './WebsocketDispatcher'

if( ! window.websocket ) {
  /* protocol = 'wss://' */
  let protocol = 'ws://'
  let host = window.location.hostname
  let websocketPort = 8081
  /* let websocketPath = '/ws' */
  let websocketPath = ''

  if( 'MozWebSocket' in window ) {
    window.websocket = new MozWebSocket(protocol + host + ':' + websocketPort + websocketPath)
  } else if( 'WebSocket' in window ) {
    window.websocket = new WebSocket(protocol + host + ':' + websocketPort + websocketPath)
  }

  window.websocket.onopen = function (e) {
  }

  window.websocket.onmessage = function (e) {
    let data = JSON.parse(e.data)
    WebsocketDispatcher.dispatch(data)
  }

  window.websocket.waitForWebsocketReady = function (callback, interval) {
    if( window.websocket.readyState === 1) {
      callback()
    } else {
      setTimeout( function () {
        window.websocket.waitForWebsocketReady(callback, interval)
      }, interval)
    }
  }

  window.websocket.transmit = function (payload) {
    window.websocket.waitForWebsocketReady( function () {
      window.websocket.send(payload)
    }, 500)
  }
}

export default window.websocket
