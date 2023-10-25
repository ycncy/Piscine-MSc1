<template>
  <div v-if="!this.is_logged()">
    <div v-if="error">{{error}}</div>
    <div v-if="login_form_display">
      <div>
        <label for="username">Nom d'utilisateur :</label>
        <input type="text" id="username" name="username" v-model="user_info.username" required>

        <label for="email">Email :</label>
        <input type="text" id="email" name="email" v-model="user_info.email" required>

        <button @click="this.login()">Connecter</button>
      </div>
      <button @click="() => {login_form_display = !login_form_display}">S'inscrire plutôt</button>
    </div>
    <div v-else>
      <div>
        <label for="username">Nom d'utilisateur :</label>
        <input type="text" id="username" name="username" v-model="user_info.username" required>

        <label for="email">Email :</label>
        <input type="text" id="email" name="email" v-model="user_info.email" required>

        <label for="Role">Role :</label>
        <input type="text" id="Role" name="Role" v-model="user_info.role" required>

        <button @click="this.register()">s'inscrire</button>
      </div>
      <button @click="() => {login_form_display = !login_form_display}">Se connecter plutôt</button>
    </div>
  </div>
</template>

<script>
import {authentication_service} from "@/services/authentication.service";
import {users_service} from "@/services/users.service";

export default {
  data() {
    return {
      user_info: {
        username: "",
        email: "",
        role: "",
      },
      login_form_display: true,
      error: undefined
    }
  },
  methods: {
    is_logged() {
      return authentication_service.is_logged();
    },
    async login() {
      const response = await users_service.get_user_by_credentials(
          this.user_info.username,
          this.user_info.email
      );

      switch (response.status_code) {
        case 200:
          authentication_service.set_user(response.data);
          this.$router.push("/");
          break;
        case 404:
          this.error = "Invalid credentials";
      }
    },
    async register() {
      const response = await users_service.create_user(
          this.user_info.username,
          this.user_info.email,
          this.user_info.role,
      );

      switch (response.status_code) {
        case 201:
          authentication_service.set_user(response.data);
          this.$router.push("/");
          break;
        case 403:
          this.error = "User already exists";
      }
    }
  }
}
</script>