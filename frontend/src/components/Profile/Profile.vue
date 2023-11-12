<template>
  <div class="flex flex-row w-full justify-around py-12">
    <div class="flex flex-col gap-6">
      <p class="text-white text-3xl">Your information</p>
      <form @submit.prevent="updateCurrentUser" class="space-y-5 bg-white shadow p-4 py-6 sm:p-6 sm:rounded-lg">
        <Loader v-if="(!this.teams && this.authenticated_user.role !== 'employee') || !this.team" class="flex justify-center"/>
        <div v-else class="space-y-5">
          <div>
            <label>Username</label>
            <input type="text" required v-model="current_user_form_info.username"
                   :placeholder="authenticated_user.username"
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
                :placeholder="authenticated_user.email" name="email"
                v-model="current_user_form_info.email" required>
          </div>
          <div v-if="this.authenticated_user.role !== 'employee'" class="flex flex-col gap-2">
            <label>Team</label>
            <select
                class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
                v-model="current_user_form_info.team"
                name="role" required>
              <option selected disabled>Select team</option>
              <option v-for="team in teams" :key="team.id" :value="team.id">{{ team.name }}</option>
            </select>
          </div>
          <button
              type="submit"
              class="w-full px-4 py-2 text-white font-medium bg-[#161717] hover:bg-gray-600 active:bg-indigo-600 rounded-lg duration-150">
            Update
          </button>

        </div>
      </form>
    </div>
    <div class="w-1/2 flex flex-col gap-6">
      <p class="text-white text-3xl">Your team</p>
      <div class="shadow-sm border rounded-lg overflow-x-auto">
        <div id="updateUser">
          <PopupForm v-if="popupTriggers.trigger_update"
                     :togglePopup="() => togglePopup('trigger_update')">
            <form @submit.prevent="updateUser" class="space-y-5">
              <h1 class="text-2xl">Update user : {{ user_form_info.username }}</h1>
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
                    :placeholder="user_form_info.email" name="email"
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
              <div class="flex flex-col gap-2">
                <label>Team</label>
                <select
                    class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
                    v-model="user_form_info.team"
                    name="role" required>
                  <option selected disabled>Select team</option>
                  <option v-for="team in teams" :key="team.id" :value="team.id">{{ team.name }}</option>
                </select>
              </div>
              <button
                  type="submit"
                  class="w-full px-4 py-2 text-white font-medium bg-[#161717] hover:bg-gray-600 active:bg-indigo-600 rounded-lg duration-150">
                Update
              </button>
            </form>
          </PopupForm>
        </div>
        <div id="deleteUser">
          <PopupForm v-if="popupTriggers.trigger_delete" :togglePopup="() => togglePopup('trigger_delete')">
            <form @submit.prevent="deleteUser" action="/">
              <h1 class="text-xl text-[#161717]">Are you sure to delete user : {{ this.user_form_info.username }} ?</h1>
              <div class="items-center gap-2 mt-3 text-sm sm:flex">
                <button
                    class="w-full mt-2 p-2.5 flex-1 text-white bg-red-600 rounded-md ring-offset-2 ring-red-600 focus:ring-2">
                  Delete
                </button>
              </div>
            </form>
          </PopupForm>
        </div>
        <table class="w-full text-sm text-left">
          <thead class="bg-gray-50 text-gray-600 uppercase font-medium border-b">
          <tr>
            <th class="py-3 px-6">Username</th>
            <th class="py-3 px-6">Role</th>
            <th v-if="['administrator', 'general_manager'].includes(this.authenticated_user.role)"
                class="py-3 px-6"></th>
          </tr>
          </thead>
          <tbody class="bg-white text-gray-500 divide-y">
          <tr v-if="!team">
            <td class="px-6 py-4 whitespace-nowrap text-center" :colspan="5">
              <Loader class="flex justify-center"/>
            </td>
          </tr>
          <tr v-else-if="this.team.length === 0">
            <td class="px-6 py-4 whitespace-nowrap text-center" :colspan="5">No working times found for this user</td>
          </tr>
          <tr v-else v-for="(user, index) in this.team" :key="index">
            <td class="px-6 py-4 whitespace-nowrap">{{ user["username"] }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ user["role"] }}</td>
            <td v-if="['administrator', 'general_manager'].includes(this.authenticated_user.role)"
                class="text-left px-6 whitespace-nowrap w-1/12 space-x-4">
              <button class="text-yellow-600" @click="toggleEditUser(user)">
                  <span class="material-symbols-outlined">
                    edit
                  </span>
              </button>
              <button class="text-red-600" @click="toggleDeleteUser(user)">
                  <span class="material-symbols-outlined">
                    delete
                  </span>
              </button>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>

import Loader from "@/components/Loader.vue";
import {authentication_service} from "@/services/authentication.service";
import {users_service} from "@/services/users.service";
import {teams_service} from "@/services/teams.service";
import moment from "moment/moment";
import {ref} from "vue";
import PopupForm from "@/components/PopupForm.vue";

export default {
  name: "Profile",
  components: {PopupForm, Loader},
  data() {
    return {
      team: undefined,
      teams: undefined,
      user_form_info: {},
      current_user_form_info: {},
      authenticated_user: {}
    }
  },
  setup() {
    const popupTriggers = ref({
      trigger_update: false,
      trigger_delete: false,
      trigger_create: false,
      trigger_display: false
    });
    const togglePopup = (trigger) => {
      popupTriggers.value[trigger] = !popupTriggers.value[trigger];
    }
    return {
      popupTriggers,
      togglePopup
    }
  },
  methods: {
    async updateUser() {
      const user_parsed = this.current_user;

      let response = undefined

      if (this.authenticated_user.role !== 'employee') {
        response = await users_service.update_user(
            user_parsed.id,
            this.user_form_info.username,
            this.user_form_info.email,
            this.user_form_info.role,
            this.user_form_info.team
        );
      } else {
        response = await users_service.update_user(
            user_parsed.id,
            this.user_form_info.username,
            this.user_form_info.email,
            this.authenticated_user.role,
            this.authenticated_user.team
        );
      }

      switch (response.status_code) {
        case 200:
          this.togglePopup('trigger_update');
          window.location.reload()
          break;
        case 403:
          this.error = "User already exists";
      }
    },
    async updateCurrentUser() {
      const user_parsed = this.current_user;
      const response = await users_service.update_user(
          user_parsed.id,
          this.user_form_info.username,
          this.user_form_info.email,
          this.user_form_info.role,
          this.user_form_info.team
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
          this.user_form_info.id,
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
    formatDateTime(dateTime) {
      return moment(new Date(dateTime)).format('MMMM Do YYYY, h:mm');
    },
    toggleEditUser(user) {
      this.user_form_info = Object.assign({}, user);
      this.togglePopup('trigger_update');
    },
    toggleDeleteUser(user) {
      this.user_form_info = Object.assign({}, user);
      this.togglePopup('trigger_delete');
    },
  },
  async created() {
    this.authenticated_user = JSON.parse(authentication_service.get_user())

    if (this.authenticated_user.role !== "employee") {
      await teams_service.get_all_teams()
          .then(response => {
            this.teams = response.data;
          })
    }

    await users_service.get_user_by_id(this.authenticated_user.id)
        .then((response) => {
          this.authenticated_user = response.data
        })
        .catch(() => {
          this.$router.push("/")
        });

    await teams_service.get_team_by_id(this.authenticated_user.team_id)
        .then((response) => {
          this.team = response.data;
        });
  }
}

</script>