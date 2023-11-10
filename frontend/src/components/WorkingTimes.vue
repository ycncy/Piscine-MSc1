<template>
  <div class="p-4 gap-3 flex flex-col">
    <div class="w-full mx-auto px-4">
      <div class="items-start justify-between md:flex">
        <div>
          <h3 class="text-white font-bold text-2xl">
            Working Times
          </h3>
        </div>
        <div v-if="['administrator', 'general_manager'].includes(authenticated_user.role)">
          <button @click="togglePopup('trigger_create')"
                  class="inline-block px-4 py-2 text-white duration-150 font-medium bg-[#161717] rounded-lg hover:bg-gray-400 md:text-sm">
            New Working Time
          </button>
        </div>
      </div>
      <div class="mt-12 shadow-sm border rounded-lg overflow-x-auto">
        <table class="w-full text-sm text-left">
          <thead class="bg-gray-50 text-gray-600 uppercase font-medium border-b">
          <tr>
            <th class="py-3 px-6">Username</th>
            <th class="py-3 px-6">Start datetime</th>
            <th class="py-3 px-6">End datetime</th>
            <th v-if="['administrator', 'general_manager'].includes(authenticated_user.role)" class="py-3 px-6"></th>
          </tr>
          </thead>
          <tbody class="bg-white text-gray-500 divide-y">
          <tr v-if="!working_times">
            <td class="px-6 py-4 whitespace-nowrap text-center" :colspan="5">
              <Loader class="flex justify-center"/>
            </td>
          </tr>
          <tr v-else-if="this.working_times.length === 0">
            <td class="px-6 py-4 whitespace-nowrap text-center" :colspan="5">No working times found for this user</td>
          </tr>
          <tr v-else v-for="(working_time, index) in working_times" :key="index">
            <td class="px-6 py-4 whitespace-nowrap">{{ current_user["username"] }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ formatDateTime(working_time.start_time) }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ formatDateTime(working_time.end_time) }}</td>
            <td v-if="['administrator', 'general_manager'].includes(authenticated_user.role)"
                class="text-left px-6 whitespace-nowrap w-1/12 space-x-4">
              <button class="text-yellow-600" @click="toggleEditWorkingTime(working_time)">
                  <span class="material-symbols-outlined">
                    edit
                  </span>
              </button>
              <button class="text-red-600" @click="toggleDeleteWorkingTime(working_time)">
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
    <div id="createWorkingTime">
      <PopupForm v-if="popupTriggers.trigger_create" :togglePopup="() => togglePopup('trigger_create')">
        <form @submit.prevent="createWorkingTime" class="space-y-5">
          <h1 class="text-2xl">Create new Working Time</h1>
          <div>
            <label class="font-medium">Start time</label>
            <input type="text" required v-model="working_time_info.start_time"
                   placeholder="Start datetime"
                   class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
            />
          </div>
          <div>
            <label class="font-medium">End time</label>
            <input
                type="text"
                required
                placeholder="End datetime"
                v-model="working_time_info.end_time"
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
    <div id="updateWorkingTime">
      <PopupForm v-if="popupTriggers.trigger_update" :togglePopup="() => togglePopup('trigger_update')">
        <form @submit.prevent="updateWorkingTime" class="space-y-5">
          <h1 class="text-2xl">Update Working Time</h1>
          <div>
            <label class="font-medium">Start time</label>
            <input type="text" required v-model="working_time_info.start_time"
                   :placeholder="working_time_info.start_time"
                   class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
            />
          </div>
          <div>
            <label class="font-medium">End time</label>
            <input
                type="text"
                required
                :placeholder="working_time_info.end_time"
                v-model="working_time_info.end_time"
                class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"
            />
          </div>
          <button
              type="submit"
              class="w-full px-4 py-2 text-white font-medium bg-[#161717] hover:bg-gray-600 active:bg-indigo-600 rounded-lg duration-150">
            Update
          </button>
        </form>
      </PopupForm>
    </div>
    <div id="deleteWorkingTime">
      <PopupForm v-if="popupTriggers.trigger_delete" :togglePopup="() => togglePopup('trigger_delete')">
        <form @submit.prevent="deleteWorkingTime" action="/frontend/public">
          <h1 class="text-xl text-[#161717]">Are you sure to delete this Working Time ?</h1>
          <div class="items-center gap-2 mt-3 text-sm sm:flex">
            <button
                class="w-full mt-2 p-2.5 flex-1 text-white bg-red-600 rounded-md ring-offset-2 ring-red-600 focus:ring-2">
              Delete
            </button>
          </div>
        </form>
      </PopupForm>
    </div>
    <div id="displayWorkingTime">
      <PopupForm v-if="popupTriggers.trigger_display" :togglePopup="() => togglePopup('trigger_display')">
        <form class="flex flex-col gap-2" @submit.prevent="updateWorkingTime" action="/frontend/public">
          <div>
            <label class="font-medium">Start time</label>
            <input type="text" v-model="working_time_info.start_time" :placeholder="working_time_info.start_time"
                   class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"/>
          </div>
          <div>
            <label class="font-medium">End time</label>
            <input type="text" v-model="working_time_info.end_time" :placeholder="working_time_info.end_time"
                   class="w-full mt-2 px-3 py-2 text-gray-500 bg-transparent outline-none border focus:border-[#161717] shadow-sm rounded-lg"/>
          </div>
          <div class="flex gap-2">
            <button type="submit"
                    class="w-full px-4 py-2 text-white font-medium bg-[#161717] hover:bg-gray-600 active:bg-indigo-600 rounded-lg duration-150">
              Update
            </button>
            <button @click="confirmDelete"
                    class="w-full px-4 py-2 text-white font-medium bg-red-600 hover:bg-red-700 active:bg-red-800 rounded-lg duration-150">
              Delete
            </button>
          </div>
        </form>
      </PopupForm>
    </div>
    <div class="flex justify-center">
      <FullCalendar class="w-full border rounded-lg bg-white p-6" :options="calendarOptions" ref="fullCalendar"/>
    </div>
  </div>
</template>

<script>
import User from "@/App.vue";
import PopupForm from "@/components/PopupForm.vue";
import {working_time_service} from "@/services/workingtimes.service"
import moment from "moment";
import {users_service} from "@/services/users.service";
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import listPlugin from '@fullcalendar/list'
import {authentication_service} from "@/services/authentication.service";
import {ref} from "vue"
import Loader from "@/components/Loader.vue";

export default {
  name: "WorkingTimes",
  components: {Loader, PopupForm, User, FullCalendar},
  data() {
    return {
      authenticated_user: {},
      working_times: undefined,
      current_user: undefined,
      editor_mode_boolean: false,
      working_time_info: {},
      selectedWorkingTime: null,

      calendarOptions: {
        plugins: [dayGridPlugin, timeGridPlugin, listPlugin, interactionPlugin],
        initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        editable: true,
        selectable: true,
        weekends: true,
        select: (arg) => {
          const workingtime = {
            start_time: moment(new Date(arg.start)).format('YYYY-MM-DDTHH:mm:ss'),
            end_time: moment(new Date(arg.end)).format('YYYY-MM-DDTHH:mm:ss'),
          }
          this.toggleCreateWorkingTime(workingtime)
        },
        eventClick: (arg) => {
          this.selectedWorkingTime = {
            id: arg.event.id,
            start_time: moment(new Date(arg.event.start)).format('YYYY-MM-DDTHH:mm:ss'),
            end_time: moment(new Date(arg.event.end)).format('YYYY-MM-DDTHH:mm:ss'),

          }
          this.toggleDisplayWorkingTime(this.selectedWorkingTime);
        }
      },
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
    formatDateTime(dateTime) {
      return moment(new Date(dateTime)).format('MMMM Do YYYY, h:mm');
    },
    toggleEditWorkingTime(working_time) {
      this.working_time_info = Object.assign({}, working_time);
      this.togglePopup('trigger_update');
    },
    toggleDeleteWorkingTime(working_time) {
      this.working_time_info = Object.assign({}, working_time);
      this.togglePopup('trigger_delete');
    },
    toggleDisplayWorkingTime(working_time) {
      this.working_time_info = Object.assign({}, working_time);
      this.togglePopup('trigger_display');
    },
    toggleCreateWorkingTime(working_time) {
      this.working_time_info = Object.assign({}, working_time);
      this.togglePopup('trigger_create');
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
          window.location.reload()
          break;
        case 403:
          this.error = "Working_time already exists";
      }
    },
    async deleteWorkingTime() {
      const response = await working_time_service.delete_working_time(
          this.working_time_info.id
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
    async confirmDelete() {
      this.togglePopup('trigger_delete');
      this.togglePopup('trigger_display')
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
          window.location.reload()
          break;
        case 403:
          this.error = "Working_time already exists";
      }
    },
  },
  async mounted() {
    this.authenticated_user = JSON.parse(authentication_service.get_user())

    const user_id = this.$route.params.userID;

    if (!isNaN(parseInt(user_id))) {
      await users_service.get_user_by_id(user_id)
          .then((response) => {
            this.current_user = response.data
          })
          .catch(() => {
            this.$router.push("/")
          });

      await working_time_service.get_working_times_by_id(user_id)
          .then((result) => {
            this.working_times = result.data;
          });
    }
  },
  async created() {
    const user_id = this.$route.params.userID;

    if (!isNaN(parseInt(user_id))) {
      await users_service.get_user_by_id(user_id).then((response) => {
        if (response.status_code === 404) {
          this.$router.push("/")
        } else {
          this.current_user = response.data
        }
      }).catch(() => {
        this.$router.push("/")
      });

      working_time_service.get_working_times_by_id(user_id).then((result) => {
        this.workingtimes = result.data;

        for (const workingTime of this.workingtimes) {
          this.$refs.fullCalendar.getApi().addEvent({
            id: workingTime.id,
            title: 'Working Time',
            start: workingTime.start_time,
            end: workingTime.end_time,
            allDay: false,
          });
        }
      });
    } else {
      this.$router.push("/")
    }
  },
};
</script>