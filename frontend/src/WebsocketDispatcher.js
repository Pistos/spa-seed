import backend from './backend'

if( ! window.websocketDispatcher ) {
  window.websocketDispatcher = {
    currentId: 0,
    handlers: {
      '/things/create': [
        function (response) {
          backend.actions.dispatchThingCreate(response)
        },
      ],
    },

    nextId: function () {
      let id = this.currentId
      this.currentId++
      return ''+id
    },
    on: function (message, handler) {
      this.handlers[message] = this.handlers[message] || []
      this.handlers[message].push(handler)
    },
    addResponseHandler: function (handler) {
      let id = this.nextId()
      this.handlers[id] = handler
      return id
    },
    dispatch: function (data) {
      if( data.id ) {
        this.handlers[data.id].call(this, data.response)
        delete this.handlers[data.id]
      } else if( data.message ) {
        this.handlers[data.message].forEach( function (handler, i) {
          handler.call(this, data.response)
        } )
      }
    },
  }
}

export default window.websocketDispatcher
