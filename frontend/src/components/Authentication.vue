<template>
  <p>{{store.state.user}}</p>
  <div v-if="store.state.user">
    <form>
      <label for="username">Nom d'utilisateur :</label>
      <input type="text" id="username" name="username" required>

      <label for="email">Email :</label>
      <input type="text" id="email" name="email" required>

      <button @click="store.commit('setUser', null)">connecter</button>
    </form>
  </div>
  <div v-else>
    <form>
      <label for="username">Nom d'utilisateur :</label>
      <input type="text" id="username" name="username" required>

      <label for="email">Email :</label>
      <input type="text" id="email" name="email" required>

      <label for="Role">Role :</label>
      <input type="text" id="Role" name="Role" required>

      <button @click="store.commit('setUser', {username: 'username'})">s'inscrire</button>
    </form>
  </div>
</template>

<script>
import store from "@/Store";

export default {
  computed: {
    store() {
      return store
    }
  },
  data() {
    return {
      isLogin: false
    }
  },
  methods: {
    setLogin() {
      this.isLogin = !this.isLogin;
    }
  }
}
</script>