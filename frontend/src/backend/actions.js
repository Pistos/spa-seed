import Vue from 'vue'
import JwtInterface from '../JwtInterface'

const apiRoot = 'http://'+window.location.hostname+':8082/api'

function apiGet (route, data) {
  let resource = Vue.resource(apiRoot+route)
  let data_ = Object.assign(
    { jwt: JwtInterface.getters.jwt() },
    data
  )

  return resource.get(data_)
}

function apiPost (route, data) {
  let resource = Vue.resource(apiRoot+route)
  let data_ = Object.assign(
    { jwt: JwtInterface.getters.jwt() },
    data
  )

  return resource.save(data_)
}

export const thingsLoad = ({dispatch, state}) => {
  apiGet('/things').then(
    function (response) {
      dispatch('THINGS_SET', response.data)
    },
    function (response) {
      console.log('load error: ')
      console.log(response)
    }
  )
}

export const thingCreate = ({dispatch, state}, name, description) => {
  apiPost(
    '/things',
    {
      name: name,
      description: description,
    }
  ).then(
    function (response) {
      dispatch('THING_CREATE', response.data)
    },
    function (response) {
      console.log('create error: ')
      console.log(response)
    }
  )
}
