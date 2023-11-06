<template>
  <div>
    <h2>Connexion</h2>
    <form @submit.prevent="login">
      <p v-if="error">{{ this.error }}</p>
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" v-model="email" required>
      </div>
      <div class="form-group">
        <label for="password">Mot de passe</label>
        <input type="password" id="password" v-model="password" required>
      </div>
      <button type="submit">Se connecter</button>
    </form>
  </div>
  <button @click="test">TEST</button>
</template>

<script>
import {authentication_service} from "@/services/authentication.service";
import axios from "axios";

export default {
  data() {
    return {
      email: '',
      password: '',
      error: undefined
    };
  },
  methods: {
    async login() {
      const response = await authentication_service.login(
          this.email,
          this.password
      );

      if (response.status_code === 200) {
        this.$router.push("/");
      } else {
        this.error = response.error;
      }
    },
    async test() {
      const resp = await axios.get("http://localhost:4000/api/users/all", {withCredentials: true});

      console.log(resp)
    }
  },
};
</script>
