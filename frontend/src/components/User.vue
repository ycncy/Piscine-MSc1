<template>
  <div class="flex">
    <div :class="{ 'hidden': !isSidebarVisible }" class="bg-[#161717] flex flex-col p-6 gap-10 items-center">
      <h1 class="text-xl text-gray-400">Time Manager</h1>
      <div>
        <div id="createTeam">
          <PopupForm v-if="popupTriggers.trigger_create_team"
                     :togglePopup="() => togglePopup('trigger_create_team')">
            <form @submit.prevent="createTeam" class="space-y-5">
              <h1 class="text-2xl">Create Team</h1>
              <div>
                <label>Team name</label>
                <input type="text" required v-model="team_form_info.name"
                       placeholder="Team name"
                       class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
                />
              </div>
              <button
                  type="submit"
                  class="w-full px-4 py-2 text-white font-medium bg-[#161717] hover:bg-gray-600 active:bg-indigo-600 rounded-lg duration-150">
                Create
              </button>
            </form>
          </PopupForm>
        </div>
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
      <div id="selectUser" class="w-1/2 flex flex-col gap-4 justify-end items-center">
        <div class="shadow-sm border rounded-lg overflow-x-auto">
          <div class="flex flex-row w-full px-2 border bg-white">
            <div class="flex flex-col gap-2 w-3/4 justify-center">
              <input
                  type="text"
                  v-model="searchQuery"
                  @input="searchUsers"
                  placeholder="Search user"
                  class="block py-2.5 px-0 w-full text-sm text-gray-500 bg-transparent appearance-none dark:text-gray-400 dark:border-gray-500 focus:outline-none focus:ring-0 focus:border-gray-200 peer"
              />
            </div>
          </div>
          <table class="w-full text-sm text-left border">
            <thead class="bg-gray-50 text-gray-600 uppercase font-medium border-b">
            <tr>
              <th class="py-3 px-6">Username</th>
              <th class="py-3 px-6">Role</th>
              <th class="py-3 px-6"></th>
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
            <tr v-else
                v-for="(user, index) in [...this.team].slice(((this.currentPage - 1) * this.itemsPerPage), (((this.currentPage - 1) * this.itemsPerPage) + this.itemsPerPage))"
                :key="index">
              <td class="px-6 py-4 whitespace-nowrap">{{ user["username"] }}</td>
              <td class="px-6 py-4 whitespace-nowrap">{{ user["role"] }}</td>
              <td class="px-6 py-4 whitespace-nowrap">
                <button @click="redirectToTable(user)" class="text-white">
                  <svg class="w-4 h-4 text-gray-400" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                       viewBox="0 0 20 20">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z"/>
                  </svg>
                </button>
              </td>
            </tr>
            </tbody>
          </table>
          <div v-if="this.team && this.team.length >= 5" class="flex border flex-row bg-white gap-2 justify-around p-2 items-center">
            <button @click="currentPage--" :disabled="currentPage === 1" class="text-[#161717] bg-gray-300 p-2 rounded">Previous</button>
            <span>Page {{ currentPage }}</span>
            <button class="text-[#161717] bg-gray-300 p-2 rounded" @click="currentPage++" :disabled="endIndex >= teams.length">Next</button>
          </div>
          <div class="flex border flex-row bg-white gap-2 justify-around p-2 items-center">
            <button class="text-[#161717] bg-gray-300 rounded-full p-5 w-8 h-8 flex items-center justify-center" @click="() => togglePopup('trigger_create_team')" type="button"><span class="material-symbols-outlined"> group_add </span></button>
            <button class="text-[#161717] bg-gray-300 rounded-full p-5 w-8 h-8 flex items-center justify-center" @click="() => togglePopup('trigger_create')" type="button"><span class="material-symbols-outlined"> person_add </span></button>
            <button v-if="this.current_user" class="text-[#161717] bg-gray-300 rounded-full p-5 w-8 h-8 flex items-center justify-center" @click="() => togglePopup('trigger_update')" type="button"><span class="material-symbols-outlined"> manage_accounts </span></button>
            <button v-if="this.current_user" class="text-[#161717] bg-gray-300 rounded-full p-5 w-8 h-8 flex items-center justify-center" @click="() => togglePopup('trigger_delete')" type="button"><span class="material-symbols-outlined">person_remove</span></button>
          </div>
        </div>
      </div>
    </div>
    <div class="flex items-center">
      <button v-if="isSidebarVisible" @click="$emit('toggleSidebar')" class="bg-[#161717] rounded-r-full flex justify-center absolute py-4 top-1/4">
        <span class="material-symbols-outlined text-white">
          arrow_back_ios
        </span>
      </button>
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
import {teams_service} from "@/services/teams.service";
import Loader from "@/components/Loader.vue";

export default {
  name: "User",
  props: {
    isSidebarVisible: Boolean,
  },
  data() {
    return {
      authenticated_user: {},
      current_user: undefined,
      team: undefined,
      team_cache: undefined,
      selected_user: {},
      user_form_info: {},
      team_form_info: {},
      users: [],
      teams: [],
      error: undefined,
      currentPage: 1,
      itemsPerPage: 5,
      searchQuery: "",
      searchResults: [],
    }
  },
  setup() {
    const popupTriggers = ref({
      trigger_create_team: false,
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
  components: {Loader, Clocks, Logout, PopupForm},
  methods: {
    startIndex() {
      return (this.currentPage - 1) * this.itemsPerPage;
    },
    endIndex() {
      return this.startIndex + this.itemsPerPage;
    },
    async redirectToTable(user) {
      if (this.$route.fullPath === "/dashboard") {
        this.$router.push({name: "TeamDashboard", params: {userID: user.id}});
      } else {
        this.$router.replace({params: {userID: user.id}})
      }
      this.current_user = this.selected_user;
    },
    async createTeam() {
      const response = await teams_service.create_team(
          this.team_form_info.name
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
    async createUser() {
      console.log(this.user_form_info)
      const response = await users_service.create_user(
          this.user_form_info.username,
          this.user_form_info.email,
          this.user_form_info.password,
          this.user_form_info.role,
          this.user_form_info.team
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

      if (query === "") {
        this.team = [...this.team_cache];
      } else {
        this.team = this.team.filter((user) => {
          const userString = user.username.toLowerCase();
          return userString.includes(query);
        });
      }

      this.selected_user = {};
    },
  },
  async created() {
    this.authenticated_user = JSON.parse(authentication_service.get_user());

    if (this.authenticated_user.role !== "employee") {
      const user_id = this.$route.params.userID;

      if (this.$route.fullPath !== "/dashboard/profile") {
        if (!!user_id && !isNaN(parseInt(user_id))) {
          await users_service.get_user_by_id(
              user_id
          ).then(response => {
            if (response.status_code === 404) {
              this.$router.push("/")
            } else {
              this.selected_user = response.data;
              this.current_user = response.data;
            }
          }).catch(() => {
            this.$router.push("/")
          });

        } else {
          this.selected_user = {};
          this.current_user = {}
        }
      }
    }
  },
  async mounted() {
    switch (this.authenticated_user.role) {
      case "administrator":
        await users_service.get_all_users().then(response => {
          this.users = response.data;
        }).catch(() => {
        });

        await teams_service.get_all_teams().then(response => {
          this.teams = response.data
        });

        await teams_service.get_team_by_id(this.authenticated_user.team_id)
            .then((response) => {
              this.team = response.data;
              this.team_cache = response.data;
            });

        break;

      case "manager" || "general_manager" :
        await users_service.get_all_users().then(response => {
          this.users = response.data;
        }).catch(() => {
        });

        await teams_service.get_team_by_id(
            this.authenticated_user.team_id
        ).then(response => {
          this.teams = response.data
        });

        await teams_service.get_team_by_id(this.authenticated_user.team_id)
            .then((response) => {
              this.team = response.data;
              this.team_cache = response.data;
            });
        break

      default:
        break;
    }
  }
}
</script>

<style>
input:checked ~ .dot {
  transform: translateX(100%);
  background-color: #48bb78;
}
</style>