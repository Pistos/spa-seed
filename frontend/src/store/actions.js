export const dispatchThingsSet = ({dispatch, state}, things) => {
  dispatch('THINGS_SET', things)
}

// TODO: change `response` to `args`
export const dispatchThingCreate = ({dispatch, state}, response) => {
  dispatch('THING_CREATE', response)
}

// TODO: change `response` to `args`
export const dispatchThingUpdate = ({dispatch, state}, response) => {
  dispatch('THING_UPDATE', response)
}

// TODO: change `response` to `args`
export const dispatchThingDelete = ({dispatch, state}, response) => {
  dispatch('THING_DELETE', response)
}
