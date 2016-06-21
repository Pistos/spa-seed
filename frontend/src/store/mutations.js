import * as mtypes from './mutation-types'

export default {
  [mtypes.THINGS_SET] (state, newThings) {
    state.things = newThings
  },
  [mtypes.THING_CREATE] (state, createdThing) {
    state.things.push(createdThing)
  },
  [mtypes.THING_UPDATE] (state, updatedThing) {
    let thingIndex = state.things.findIndex(
      function (thing) { return thing.id === updatedThing.id }
    )
    if( thingIndex > -1 ) {
      state.things.$set(thingIndex, updatedThing)
    }
  },
  [mtypes.THING_DELETE] (state, data) {
    let deletedThing = state.things.find(
      function (thing) { return thing.id === data.id }
    )
    state.things.$remove(deletedThing)
  },
}
