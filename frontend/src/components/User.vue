<template>
  <div class="bg-[#232323] text-white flex flex-col py-5 items-center">
    <div>
      <div id="createUser">
        <PopupForm class="text-white" v-if="popupTriggers.trigger_create" :togglePopup="() => togglePopup('trigger_create')">
          <form class="text-white flex flex-col gap-6" @submit.prevent="createUser" action="/">
            <h1 class="text-2xl text-center">Create user</h1>
            <p v-if="this.error" class="text-red-500">{{ this.error }}</p>
            <div class="flex flex-col gap-2">
              <label>Username</label>
              <input type="text" class="bg-gray-200 rounded-lg p-2 focus:outline-blue-500"
                     @change="() => this.error = undefined" name="username"
                     v-model="user_form_info.username" placeholder="Username" required>
            </div>
            <div class="flex flex-col gap-2">
              <label>E-mail</label>
              <input class="bg-gray-200 rounded-lg p-2 focus:outline-blue-500" type="email"
                     @change="() => this.error = undefined"
                     pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z.]{2,15}" placeholder="E-mail address" name="email"
                     v-model="user_form_info.email" required>
            </div>
            <div class="flex flex-col gap-2">
              <label>Role</label>
              <select class="bg-gray-200 rounded-lg p-2 focus:outline-blue-500" v-model="user_form_info.role"
                      name="role" required>
                <option selected disabled>Select role</option>
                <option value="employee">Employee</option>
                <option value="manager">Manager</option>
                <option value="general_manager">General Manager</option>
              </select>
            </div>
            <button type="submit" class="rounded-lg text-white p-2 bg-blue-500">Create user</button>
          </form>
        </PopupForm>
      </div>
      <div id="updateUser" class="text-white">
        <PopupForm v-if="popupTriggers.trigger_update" :togglePopup="() => togglePopup('trigger_update')">
          <h1 class="text-2xl text-center text-white">Update user</h1>
          <h1 class="text-2xl text-center text-white">{{ this.current_user.username }}</h1>
          <form class="text-white flex flex-col gap-6" @submit.prevent="updateUser" action="/">
            <p v-if="this.error">{{ this.error }}</p>
            <div class="flex flex-col gap-2">
              <label>Username</label>
              <input class="bg-gray-200 rounded-lg p-2 focus:outline-blue-500" type="text"
                     @change="() => this.error = undefined" name="username"
                     v-model="user_form_info.username" placeholder="Username" required>
            </div>
            <div class="flex flex-col gap-2">
              <label>E-mail</label>
              <input class="bg-gray-200 rounded-lg p-2 focus:outline-blue-500" type="email"
                     @change="() => this.error = undefined"
                     pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z.]{2,15}" placeholder="E-mail address" name="email"
                     v-model="user_form_info.email" required>
            </div>
            <div class="flex flex-col gap-2">
              <label>Role</label>
              <select class="bg-gray-200 rounded-lg p-2 focus:outline-blue-500" v-model="user_form_info.role"
                      name="role" required>
                <option selected disabled>Select role</option>
                <option value="employee">Employee</option>
                <option value="manager">Manager</option>
                <option value="general_manager">General Manager</option>
              </select>
            </div>
            <button type="submit" class="rounded-lg text-white p-2 bg-blue-500">Update user</button>
          </form>
        </PopupForm>
      </div>
    </div>
    <div class="border-b py-6">
      <p class="text-3xl" v-if="this.current_user">Hello, {{this.current_user.username}}</p>
      <p v-else>No user selected</p>
    </div>
    <div id="selectUser">
      <div class="flex flex-col gap-2 p-4">
        <select class="border w-full border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" id='users'
                @change="setSelectedUser($event)">
          <option selected disabled>Select user</option>
          <option v-for="user in this.users" class="text-gray-900" :key="user.id" :value="JSON.stringify({
                id: user.id,
                username: user.username,
                email: user.email,
                role: user.role
            })">
            {{ `${user.username} -- ${user.role}` }}
          </option>
        </select>

        <button class="p-4 w-full flex justify-center items-center" @click="redirectTo">Select
          user
        </button>
      </div>
    </div>

    <div class="flex flex-col p-4 items-center">
      <button class="px-4 py-8 h-10 flex items-center" @click="() => togglePopup('trigger_create')">Create user</button>
      <button class="px-4 py-8 h-10 flex items-center" @click="() => togglePopup('trigger_update')">Update user</button>
      <button class="px-4 py-8 h-10 flex items-center" id="deleteUser" @click="deleteUser">Delete user</button>
    </div>
  </div>
</template>

<script>
import PopupForm from "@/components/PopupForm.vue";
import {users_service} from "@/services/users.service";
import {ref} from "vue";

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

      this.current_user = this.selected_user;
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
  },
  async mounted() {
    const user_id = this.$route.params.userID;

    await users_service.get_user_by_id(
        user_id
    ).then(response => {
      this.current_user = response.data
    }).catch(() => {
    });

    await users_service.get_all_users().then(response => {
      this.users = response.data
    });
  },
}
</script>