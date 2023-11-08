<template>
  <div class="bg-[#242424] h-16 flex flex-row p-6 justify-between items-center">
    <h1 class="text-xl text-gray-400">Time Manager</h1>
    <div>
      <div id="createUser">
        <PopupForm v-if="popupTriggers.trigger_create"
                   :togglePopup="() => togglePopup('trigger_create')">
          <form @submit.prevent="createUser" class="space-y-5">
            <h1 class="text-2xl">Create user</h1>
            <div>
              <label>Username</label>
              <input type="text" required v-model="user_form_info.username"
                     placeholder="Username"
                     class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
              />
            </div>
            <div>
              <label>E-mail</label>
              <input
                  class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
                  type="email"
                  @change="() => this.error = undefined"
                  pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z.]{2,15}" placeholder="E-mail address" name="email"
                  v-model="user_form_info.email" required>
            </div>
            <div>
              <label>Password</label>
              <input type="password" required v-model="user_form_info.password"
                     placeholder="Password"
                     class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
              />
            </div>
            <div class="flex flex-col gap-2">
              <label>Role</label>
              <select
                  class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
                  v-model="user_form_info.role"
                  name="role" required>
                <option selected disabled>Select role</option>
                <option value="employee">Employee</option>
                <option value="manager">Manager</option>
                <option value="general_manager">General Manager</option>
              </select>
            </div>
            <button
                type="submit"
                class="w-full px-4 py-2 text-white font-medium bg-[#161717] hover:bg-gray-600 active:bg-indigo-600 rounded-lg duration-150">
              Create
            </button>
          </form>
        </PopupForm>
      </div>
      <div id="updateUser">
        <PopupForm v-if="popupTriggers.trigger_update"
                   :togglePopup="() => togglePopup('trigger_update')">
          <form @submit.prevent="updateUser" class="space-y-5">
            <h1 class="text-2xl">Update user : {{ current_user.username }}</h1>
            <div>
              <label>Username</label>
              <input type="text" required v-model="user_form_info.username"
                     :placeholder="current_user.username"
                     class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
              />
            </div>
            <div>
              <label>E-mail</label>
              <input
                  class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
                  type="email"
                  @change="() => this.error = undefined"
                  pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z.]{2,15}"
                  :placeholder="current_user.email" name="email"
                  v-model="user_form_info.email" required>
            </div>
            <div class="flex flex-col gap-2">
              <label>Role</label>
              <select
                  class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
                  v-model="user_form_info.role"
                  name="role" required
              >
                <option value="" disabled selected>Select role</option>
                <option value="employee">Employee</option>
                <option value="manager">Manager</option>
                <option value="general_manager">General Manager</option>
              </select>
            </div>
            <button
                type="submit"
                class="w-full px-4 py-2 text-white font-medium bg-[#161717] hover:bg-gray-600 active:bg-indigo-600 rounded-lg duration-150">
              Create
            </button>
          </form>
        </PopupForm>
      </div>
      <div id="deleteUser">
        <PopupForm v-if="popupTriggers.trigger_delete" :togglePopup="() => togglePopup('trigger_delete')">
          <form @submit.prevent="deleteUser" action="/">
            <h1 class="text-xl text-[#161717]">Are you sure to delete user : {{ this.current_user.username }} ?</h1>
            <div class="items-center gap-2 mt-3 text-sm sm:flex">
              <button
                  class="w-full mt-2 p-2.5 flex-1 text-white bg-red-600 rounded-md ring-offset-2 ring-red-600 focus:ring-2">
                Delete
              </button>
            </div>
          </form>
        </PopupForm>
      </div>
    </div>
    <div id="selectUser"
         class="w-1/2 flex flex-row justify-end items-center">
      <div v-if="['administrator', 'general_manager', 'manager'].includes(authenticated_user.role)" class="flex flex-row w-1/3 justify-around rounded-2xl bg-[#161717]">
        <div class="flex flex-col gap-2 w-3/4 justify-center">
          <input
              type="text"
              v-model="searchQuery"
              @input="searchUsers"
              placeholder="Search user"
              @focusin="visibleResults = true"
              class="block py-2.5 px-0 w-full text-sm text-gray-500 bg-transparent appearance-none dark:text-gray-400 dark:border-gray-500 focus:outline-none focus:ring-0 focus:border-gray-200 peer"
          />

          <ul v-if="visibleResults && this.users.length > 0"
              class="text-gray-400 flex flex-col rounded text-sm absolute top-14 bg-[#161717] border-gray-600">
            <button class="p-2 hover:bg-zinc-50 hover:text-zinc-900 text-start" v-for="(result, index) in searchResults"
                    :key="index" @click="setSelectedUser(result)">{{ result.username }}
            </button>
          </ul>
        </div>
        <button @click="redirectTo" class="text-white">
          <svg class="w-4 h-4 text-gray-400" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
               viewBox="0 0 20 20">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z"/>
          </svg>
        </button>
      </div>
      <div v-if="['administrator', 'general_manager', 'manager'].includes(authenticated_user.role)" class="flex flex-row w-1/4 justify-evenly items-center">
        <button class="text-gray-300 bg-[#161717] rounded-full p-5 w-8 h-8 flex items-center justify-center"
                @click="() => togglePopup('trigger_create')" type="button"><span class="material-symbols-outlined"> person_add </span>
        </button>
        <button class="text-gray-300 bg-[#161717] rounded-full p-5 w-8 h-8 flex items-center justify-center"
                @click="() => togglePopup('trigger_update')" type="button"><span class="material-symbols-outlined"> manage_accounts </span>
        </button>
        <button class="text-gray-300 bg-[#161717] rounded-full p-5 w-8 h-8 flex items-center justify-center"
                @click="() => togglePopup('trigger_delete')" type="button"><span class="material-symbols-outlined">person_remove</span>
        </button>
      </div>
      <div class="flex flex-row gap-2 justify-evenly items-center">
        <Clocks/>
        <Logout/>
      </div>
    </div>
  </div>
</template>

<script>
import PopupForm from "@/components/PopupForm.vue";
import {users_service} from "@/services/users.service";
import {ref} from "vue";
import {authentication_service} from "@/services/authentication.service";
import Logout from "@/components/Authentication/Logout.vue";
import Clocks from "@/components/Clocks.vue";

export default {
  name: "User",
  data() {
    return {
      authenticated_user: {},
      current_user: undefined,
      selected_user: {},
      user_form_info: {},
      users: [],
      error: undefined,
      searchQuery: "",
      searchResults: [],
      visibleResults: false,
    }
  },
  setup() {
    const popupTriggers = ref({
      trigger_create: false,
      trigger_update: false,
      trigger_delete: false
    });
    const togglePopup = (trigger) => {
      popupTriggers.value[trigger] = !popupTriggers.value[trigger];
    }

    return {
      popupTriggers,
      togglePopup
    }
  },
  components: {Clocks, Logout, PopupForm},
  methods: {
    async redirectTo() {
      if (this.$route.fullPath === "/dashboard") {
        this.$router.push({name: "WorkingTimes", params: {userID: this.selected_user.id}});
      } else {
        this.$router.replace({params: {userID: this.selected_user.id}})
      }
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
          this.user_form_info.password,
          this.user_form_info.role,
      );

      switch (response.status_code) {
        case 201:
          this.togglePopup('trigger_create');
          window.location.reload()
          break;
        case 422:
          this.error = "Non-valid email format";
          break;
        case 403:
          this.error = "User already exists";
      }
    },
    async updateUser() {
      const user_parsed = this.current_user;
      const response = await users_service.update_user(
          user_parsed.id,
          this.user_form_info.username,
          this.user_form_info.email,
          this.user_form_info.role,
      );

      switch (response.status_code) {
        case 200:
          this.togglePopup('trigger_update');
          window.location.reload()
          break;
        case 403:
          this.error = "User already exists";
      }
    },
    async deleteUser() {
      const response = await users_service.delete_user(
          this.current_user.id,
      );

      switch (response.status_code) {
        case 204:
          this.togglePopup('trigger_delete');
          window.location.reload()
          break;
        case 500:
          this.togglePopup('trigger_delete');
          window.location.reload()
          break;
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
    handleClickOutside(event) {
      if (this.$el && !this.$el.contains(event.target)) {
        this.visibleResults = false;
      }
    },
  },
  async mounted() {
    this.authenticated_user = JSON.parse(authentication_service.get_user());

    if (this.authenticated_user.role !== "employee") {

      document.addEventListener('click', this.handleClickOutside);

      const user_id = this.$route.params.userID;

      if (!isNaN(parseInt(user_id))) {
        await users_service.get_user_by_id(
            user_id
        ).then(response => {
          if (response.status_code === 404) {
            this.$router.push("/")
          } else {
            this.current_user = response.data
          }
        }).catch(() => {
          this.$router.push("/")
        });
      } else {
        this.$router.push("/")
      }

      if (this.authenticated_user.role !== "employee") {
        await users_service.get_all_users().then(response => {
          this.users = response.data;
        }).catch(() => {})
      }
    }
  },
}
</script>

<style>
input:checked ~ .dot {
  transform: translateX(100%);
  background-color: #48bb78;
}
</style>