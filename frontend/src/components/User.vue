<template>
  <div class="bg-blue-900 h-screen flex-col gap-9 text-white">
    <p class="text-center text-4xl p-4">Time Manager</p>
    <div>
      <p class="text-center text-3xl p-4">User selection</p>
      <div class="text-left text-xl p-4">
        <h3 v-if="this.current_user === undefined">No user selected</h3>
        <h3 v-else id="userText">Current user : {{ current_user.username }}</h3>
      </div>

      <div id="selectUser" class="p-4 flex-col">
        <p class="py-2 text-lg">Select user in the list</p>
        <div class="flex flex-row gap-2">
          <select class="p-2 text-black w-[70%] rounded" id='users' @change="setSelectedUser($event)">
            <option selected disabled>Select user</option>
            <option v-for="user in this.users" :key="user.id" :value="JSON.stringify({
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role
      })">{{ `${user.username} -- ${user.role}` }}
            </option>
          </select>

          <button class="rounded bg-blue-600 w-[30%]" @click="redirectTo">Select user</button>
        </div>
      </div>

      <div class="flex flex-col gap-4 p-4">
        <p class="text-xl">User operations</p>
        <div class="flex flex-row gap-4 justify-left w-full">
          <button class="rounded bg-blue-600 p-2" @click="() => togglePopup('trigger_create')">Create user</button>
          <button class="rounded bg-blue-600 p-2" @click="() => togglePopup('trigger_update')">Update user</button>
          <button class="rounded bg-blue-600 p-2" id="deleteUser" @click="deleteUser">Delete user</button>
        </div>
      </div>

      <div class="flex-col gap-9">
        <div id="createUser" class="text-black">
          <PopupForm v-if="popupTriggers.trigger_create" :togglePopup="() => togglePopup('trigger_create')">
            <h2>Create new User</h2>
            <form @submit.prevent="createUser" action="/">
              <p v-if="this.error">{{ this.error }}</p>
              <div>
                <label>Username</label>
                <input type="text" @change="() => this.error = undefined" name="username"
                       v-model="user_form_info.username" placeholder="Username" required>
              </div>
              <div>
                <label>E-mail</label>
                <input type="email" @change="() => this.error = undefined"
                       pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z.]{2,15}" placeholder="E-mail address" name="email"
                       v-model="user_form_info.email" required>
              </div>
              <div>
                <label>Role</label>
                <select v-model="user_form_info.role" name="role" required>
                  <option selected disabled>Select role</option>
                  <option value="employee">Employee</option>
                  <option value="manager">Manager</option>
                  <option value="general_manager">General Manager</option>
                </select>
              </div>
              <button type="submit">Create user</button>
            </form>
          </PopupForm>
        </div>
        <div id="updateUser" class="text-black">
          <PopupForm v-if="popupTriggers.trigger_update" :togglePopup="() => togglePopup('trigger_update')">
            <h2>Update user : {{ selected_user.username }}</h2>
            <form @submit.prevent="updateUser" action="/">
              <p v-if="this.error">{{ this.error }}</p>
              <div>
                <label>Username</label>
                <input type="text" @change="() => this.error = undefined" name="username"
                       v-model="user_form_info.username" placeholder="Username" required>
              </div>
              <div>
                <label>E-mail</label>
                <input type="email" @change="() => this.error = undefined"
                       pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z.]{2,15}" placeholder="E-mail address" name="email"
                       v-model="user_form_info.email" required>
              </div>
              <div>
                <label>Role</label>
                <select v-model="user_form_info.role" name="role" required>
                  <option selected disabled>Select role</option>
                  <option value="employee">Employee</option>
                  <option value="manager">Manager</option>
                  <option value="general_manager">General Manager</option>
                </select>
              </div>
              <button type="submit">Update user</button>
            </form>
          </PopupForm>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import PopupForm from "@/components/PopupForm.vue";
import {authentication_service} from "@/services/authentication.service";
import {users_service} from "@/services/users.service";
import {ref} from "vue";
import {LogarithmicScale} from "chart.js";

export default {
  name: "User",
  setup() {
    const popupTriggers = ref({
      trigger_create: false,
      trigger_update: false
    });

    const togglePopup = (trigger) => {
      popupTriggers.value[trigger] = !popupTriggers.value[trigger];
    }

    return {
      popupTriggers,
      togglePopup
    }
  },
  components: {PopupForm},
  data() {
    return {
      current_user: undefined,
      selected_user: {},
      user_form_info: {},
      users: [],
      error: undefined
    }
  },
  methods: {
    async redirectTo() {
      this.$router.push({name: "WorkingTimes", params: {userID: this.selected_user.id}});
    },
    setSelectedUser(event) {
      this.selected_user = JSON.parse(event.target.value);
    },
    async createUser() {
      const response = await users_service.create_user(
          this.user_form_info.username,
          this.user_form_info.email,
          this.user_form_info.role,
      );

      switch (response.status_code) {
        case 201:
          this.togglePopup('trigger_create');
          break;
        case 422:
          this.error = "Non-valid email format";
          break;
        case 403:
          this.error = "User already exists";
      }
    },
    async updateUser() {
      const user_parsed = JSON.parse(this.selected_user)
      const response = await users_service.update_user(
          user_parsed.id,
          this.user_form_info.username,
          this.user_form_info.email,
          this.user_form_info.role,
      );

      switch (response.status_code) {
        case 200:
          this.togglePopup('trigger_update');
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
        case 204:
          location.reload()
          break;
        case 403:
          this.error = "User already exists";
      }
    }
  },
  async updated() {
    const user_id = this.$route.params.userID;

    await users_service.get_user_by_id(
        user_id
    ).then(response => {
      this.current_user = response.data
    }).catch(() => {});
  },
  async mounted() {
    const user_id = this.$route.params.userID;

    console.log(user_id)

    await users_service.get_user_by_id(
        user_id
    ).then(response => {
      this.current_user = response.data
    }).catch(() => {});

    await users_service.get_all_users().then(response => {
      this.users = response.data
    });
  },
}
</script>