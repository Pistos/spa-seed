/* given that self.users is already set up (part of a Vuex store) */
export default (userId, this_) => {
  return this_.users.find(
    function (user) {
      return user.id === userId
    }
  )
}
