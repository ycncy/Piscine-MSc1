<template>
  <div class="bg-[#242424] h-16 text-white flex flex-row p-6 justify-between items-center">
    <h1 class="text-xl">Time Manager</h1>
    <div>
      <div id="createUser">
        <PopupForm class="text-white" v-if="popupTriggers.trigger_create"
                   :togglePopup="() => togglePopup('trigger_create')">
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
    <div id="selectUser" class="w-1/2 flex flex-row justify-end items-center">
      <div class="flex flex-row w-1/3 justify-around rounded-2xl bg-[#161717]">
        <div class="flex flex-col gap-2 w-3/4 justify-center">
          <input
              type="text"
              v-model="searchQuery"
              @input="searchUsers"
              placeholder="Search user"
              class="block py-2.5 px-0 w-full text-sm text-gray-500 bg-transparent appearance-none dark:text-gray-400 dark:border-gray-500 focus:outline-none focus:ring-0 focus:border-gray-200 peer"
          />

          <ul class="text-gray-400 flex flex-col rounded text-sm absolute top-14 bg-[#161717] border-gray-600" v-if="visibleResults && searchResults.length > 0">
              <button class="p-2 hover:bg-zinc-50 hover:text-zinc-900 text-start" v-for="(result, index) in searchResults" :key="index" @click="setSelectedUser(result)">{{ result.username }}</button>
          </ul>
        </div>
        <button @click="redirectTo" class="text-white">
          <svg class="w-4 h-4 text-gray-400" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z"/>
          </svg>
        </button>
      </div>
      <div class="flex flex-row w-1/4 justify-evenly items-center">
        <button class="text-gray-300 bg-[#161717] rounded-full p-5 w-8 h-8 flex items-center justify-center" @click="() => togglePopup('trigger_create')" type="button"><span class="material-symbols-outlined"> person_add </span></button>
        <button class="text-gray-300 bg-[#161717] rounded-full p-5 w-8 h-8 flex items-center justify-center" @click="() => togglePopup('trigger_update')" type="button"><span class="material-symbols-outlined"> manage_accounts </span></button>
        <button class="text-gray-300 bg-[#161717] rounded-full p-5 w-8 h-8 flex items-center justify-center" @click="deleteUser" type="button"><span class="material-symbols-outlined">person_remove</span></button>
      </div>
      <label for="toggleB" class="flex items-center cursor-pointer">
      </label>
    </div>
  </div>
</template>

<script>
import PopupForm from "@/components/PopupForm.vue";
import {users_service} from "@/services/users.service";
import {ref} from "vue";

export default {
  name: "User",
  data() {
    return {
      current_user: undefined,
      selected_user: {},
      user_form_info: {},
      users: [],
      error: undefined,
      searchQuery: "",
      searchResults: [],
      visibleResults: false
    }
  },
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
  methods: {
    async redirectTo() {
      this.$router.push({name: "WorkingTimes", params: {userID: this.selected_user.id}});

      this.current_user = this.selected_user;
    },
    setSelectedUser(user) {
      this.searchQuery = user.username;
      this.selected_user = user;
      this.visibleResults = false
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
    searchUsers() {
      const query = this.searchQuery.toLowerCase();

      this.searchResults = this.users.filter((user) => {
        const userString = `${user.username}`.toLowerCase();
        this.visibleResults = true;
        return userString.includes(query);
      });

      this.selected_user = {};
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
      this.users = response.data;
    });
  },
}
</script>

<style>
input:checked ~ .dot {
  transform: translateX(100%);
  background-color: #48bb78;
}
</style>