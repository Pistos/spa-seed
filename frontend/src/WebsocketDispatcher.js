import store from './store'
import * as actions from './store/actions'

if( ! window.websocketDispatcher ) {
  window.websocketDispatcher = {
    currentId: 0,
    handlers: {
      '/things/create': [
        function (args) {
          actions.dispatchThingCreate(store, args)
        },
      ],
      '/things/update': [
        function (args) {
          actions.dispatchThingUpdate(store, args)
        },
      ],
      '/things/delete': [
        function (args) {
          actions.dispatchThingDelete(store, args)
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
          if( data.response ) {
            console.log('WARNING: found data.response when looking for data.args (message: '+data.message+')')
          }
          handler.call(this, data.args)
        } )
      }
    },
  }
}

export default window.websocketDispatcher
