import * as mtypes from './mutation-types'

export default {
  [mtypes.THINGS_SET] (state, newThings) {
    state.things = newThings
  },
  [mtypes.THING_CREATE] (state, createdThing) {
    state.things.push(createdThing)
  },
}
