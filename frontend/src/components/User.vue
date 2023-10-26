<template>
  <div id="selectUser">
    <h2>Select user in the list</h2>
    <select id='users' @change="setUser($event)">
      <option selected disabled>Select user</option>
    </select>
  </div>
  <button @click="() => togglePopup('buttonTrigger')">Create user</button>
  <CreateUser v-if="popupTriggers.buttonTrigger" :togglePopup="() => togglePopup('buttonTrigger')">
    <h2>Create new User</h2>
    <form @submit.prevent="createUser">
      <p v-if="this.error">{{this.error}}</p>
      <div>
        <label>Username</label>
        <input type="text" @change="() => this.error = undefined" name="username" v-model="user_info_to_create.username" required>
      </div>
      <div>
        <label>E-mail</label>
        <input type="email" @change="() => this.error = undefined" pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z.]{2,15}" name="email" v-model="user_info_to_create.email" required>
      </div>
      <div>
        <label>Role</label>
        <select v-model="user_info_to_create.role" name="role" required>
          <option value="employee">Employee</option>
          <option value="manager">Manager</option>
          <option value="general_manager">General Manager</option>
        </select>
      </div>
      <button type="submit">Create user</button>
    </form>
  </CreateUser>
</template>

<script>
  import CreateUser from "@/components/CreateUser.vue";

  import {authentication_service} from "@/services/authentication.service";
  import {users_service} from "@/services/users.service";
  import {ref} from "vue";

  export default {
    name: "User",
      setup() {
      const popupTriggers = ref({
        buttonTrigger: false
      });

      const togglePopup = (trigger) => {
        popupTriggers.value[trigger] = !popupTriggers.value[trigger];
      }

      return {
        popupTriggers,
        togglePopup
      }
    },
    components: {CreateUser},
    data() {
      return {
        selected_user: {},
        user_info_to_create: {},
        users: [],
        error: undefined
      }
    },
    methods: {
      setUser(event) {
        this.selected_user = event.target.value;
        authentication_service.set_user(JSON.parse(this.selected_user));
      },
      getUser() {
        return authentication_service.get_user();
      },
      async createUser() {
        const response = await users_service.create_user(
            this.user_info_to_create.username,
            this.user_info_to_create.email,
            this.user_info_to_create.role,
        );

        switch (response.status_code) {
          case 201:
            authentication_service.set_user(response.data);
            this.togglePopup('buttonTrigger');
            break;
          case 422:
            this.error = "Non-valid email format";
            break;
          case 403:
            this.error = "User already exists";
        }
      },
      async updateUser() {
        const response = await users_service.update_user(

        );

        switch (response.status_code) {
          case 200:
            authentication_service.set_user(response.data);
            location.reload()
            break;
          case 403:
            this.error = "User already exists";
        }
      },
      async deleteUser() {
        const response = await users_service.delete_user(
          JSON.parse(authentication_service.get_user()).id
        );

        switch (response.status_code) {
          case 200:
            authentication_service.delete_user(response.data);
            location.reload()
            break;
          case 403:
            this.error = "User already exists";
        }
      }
    },
    async mounted() {
      const popupTriggers = ref({
        buttonTrigger: false,
        timedTrigger: false
      });

      this.user = JSON.parse(this.getUser());

      await users_service.get_all_users().then(response => {
        this.users = response.data
      });

      let users_select_html = document.getElementById('users');

      for (const user of this.users) {
        let select_option = document.createElement("option");
        select_option.text = `${user.username} -- ${user.role}`;
        select_option.value = JSON.stringify({
          username: user.username,
          email: user.email,
          role: user.role
        });
        users_select_html.append(select_option);
      }
    }
  }
</script>