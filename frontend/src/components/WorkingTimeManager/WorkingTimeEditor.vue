<template>
  <div class="p-4 gap-3 col-md-12 flex flex-col">
    <p class="text-center align-middle text-4xl" v-if="this.working_times.length === 0">No working times found for this
      user</p>
    <div v-else class="flex flex-col gap-5">
      <div class="flex flex-row justify-between">
        <p class="text-black">Working times for user : {{ this.current_user.username }}</p>
        <button @click="() => this.togglePopup('trigger_create')" class="rounded-xl bg-blue-500 text-white p-2">Create new working time</button>
      </div>
      <table class="table-auto rounded-xl shadow-md text-l text-left text-gray-500 bg-[#232323]">
        <thead class="text-gray-500 uppercase border-gray-200 border-b">
        <tr>
          <th scope="col" class="m-auto px-6 py-3">Username</th>
          <th scope="col" class="m-auto px-6 py-3">Start Time</th>
          <th scope="col" class="m-auto px-6 py-3">End Time</th>
          <th scope="col" class="m-auto px-6 py-3">Status</th>
          <th scope="col" class="m-auto px-6 py-3">Edit</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(working_time, i) in this.working_times" :key="i">
          <td class="px-6 py-6">{{ this.current_user.username }}</td>
          <td class="px-6 py-6">{{ working_time.start_time }}</td>
          <td class="px-6 py-6">{{ working_time.end_time }}</td>
          <td class="px-6 py-6">{{ working_time.status }}</td>
          <td class="flex flex-row py-3 items-center justify-around">
            <button @click="() => toggleEditWorkingTime(working_time.id)" class="rounded-xl bg-blue-500 text-white p-2">Edit
            </button>
            <button @click="() => toggleDeleteWorkingTime(working_time.id)" class="rounded-xl bg-red-500 text-white p-2">Delete</button>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    <div id="createWorkingTime" class="text-white">
      <PopupForm v-if="popupTriggers.trigger_create" :togglePopup="() => togglePopup('trigger_create')">
        <h1 class="text-2xl text-center text-white">Create working time</h1>
        <form class="text-white flex flex-col gap-6" @submit.prevent="createWorkingTime" action="/">
          <p v-if="this.error">{{ this.error }}</p>
          <div class="flex flex-col gap-2">
            <label>Start datetime</label>
            <input class="text-black bg-gray-200 rounded-lg p-2 focus:outline-blue-500" type="text"
                   @change="() => this.error = undefined" name="start_time"
                   v-model="working_time_info.start_time" placeholder="Start datetime" required>
          </div>
          <div class="flex flex-col gap-2">
            <label>End datetime</label>
            <input class="text-black bg-gray-200 rounded-lg p-2 focus:outline-blue-500" type="text"
                   @change="() => this.error = undefined"
                   placeholder="End datetime" name="end_time"
                   v-model="working_time_info.end_time" required>
          </div>
          <button type="submit" class="rounded-lg text-white p-2 bg-blue-500">Update user</button>
        </form>
      </PopupForm>
    </div>
    <div id="updateWorkingTime" class="text-white">
      <PopupForm v-if="popupTriggers.trigger_update" :togglePopup="() => togglePopup('trigger_update')">
        <h1 class="text-2xl text-center text-white">Update working time</h1>
        <form class="text-white flex flex-col gap-6" @submit.prevent="updateWorkingTime" action="/">
          <p v-if="this.error">{{ this.error }}</p>
          <div class="flex flex-col gap-2">
            <label>Username</label>
            <input class="bg-gray-200 rounded-lg p-2 focus:outline-blue-500" type="text"
                   @change="() => this.error = undefined" name="username"
                   v-model="working_time_info.start_time" placeholder="Username" required>
          </div>
          <div class="flex flex-col gap-2">
            <label>E-mail</label>
            <input class="bg-gray-200 rounded-lg p-2 focus:outline-blue-500" type="text"
                   @change="() => this.error = undefined"
                   placeholder="E-mail address" name="email"
                   v-model="working_time_info.end_time" required>
          </div>
          <div class="flex flex-col gap-2">
          </div>
          <button type="submit" class="rounded-lg text-white p-2 bg-blue-500">Update user</button>
        </form>
      </PopupForm>
    </div>
    <div id="deleteWorkingTime" class="text-white">
      <PopupForm v-if="popupTriggers.trigger_delete" :togglePopup="() => togglePopup('trigger_delete')">
        <h1 class="text-2xl text-center text-white">Update working time</h1>
        <form class="text-white flex flex-col gap-6" @submit.prevent="deleteWorkingTime" action="/">
          <p class="text-3xl">Are you sure to delete this working time</p>
          <button type="submit" class="rounded-lg text-white p-2 bg-blue-500">Delete</button>
        </form>
      </PopupForm>
    </div>
  </div>
</template>

<script>
import User from "@/App.vue";
import {list} from "postcss";
import PopupForm from "@/components/PopupForm.vue";
import {ref} from "vue";
import {working_time_service} from "@/services/workingtimes.service"

export default {
  name: "WorkingTimeEditor",
  components: {PopupForm, User},
  data() {
    return {
      working_time_info: {
        status: false
      }
    }
  },
  props: {
    current_user: Object,
    working_times: list,
    error: "",
  },
  setup() {
    const popupTriggers = ref({
      trigger_update: false,
      trigger_delete: false,
      trigger_create: false
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
    toggleEditWorkingTime(id) {
      this.working_time_info.id = id;
      this.togglePopup('trigger_update');
    },
    toggleDeleteWorkingTime(id) {
      this.working_time_info.id = id;
      this.togglePopup('trigger_delete');
    },
    async updateWorkingTime() {
      const response = await working_time_service.update_working_time(
          this.working_time_info.id,
          this.working_time_info.start_time,
          this.working_time_info.end_time,
          this.working_time_info.status,
      );

      switch (response.status_code) {
        case 200:
          this.togglePopup('trigger_update');
          break;
        case 403:
          this.error = "Working_time already exists";
      }
    },
    async deleteWorkingTime() {
      const response = await working_time_service.delete_working_time(
          this.working_time_info.id
      );

      console.log(response)

      switch (response.status_code) {
        case 204:
          this.togglePopup('trigger_delete');
          break;
        case 403:
          this.error = "Working_time already exists";
      }
    },
    async createWorkingTime() {
      const response = await working_time_service.create_working_time(
          this.current_user.id,
          this.working_time_info.start_time,
          this.working_time_info.end_time,
          this.working_time_info.status
      );

      switch (response.status_code) {
        case 201:
          this.togglePopup('trigger_create');
          break;
        case 403:
          this.error = "Working_time already exists";
      }
    }
  }
};
</script>