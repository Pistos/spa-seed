if( ! window.websocketDispatcher ) {
  window.websocketDispatcher = {
    currentId: 0,
    handlers: {},

    nextId: function () {
      let id = this.currentId
      this.currentId++
      return ''+id
    },
    addResponseHandler: function (handler) {
      let id = this.nextId()
      this.handlers[id] = handler
      return id
    },
    dispatch: function (id, response) {
      this.handlers[id].call(this, response)
      delete this.handlers[id]
    },
  }
}

export default window.websocketDispatcher
