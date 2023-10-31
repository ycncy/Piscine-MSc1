<template>
  <div class="p-4 gap-3 col-md-12 flex flex-col">
    <p class="text-center align-middle text-4xl" v-if="this.workingtimes.length === 0">No working times found for this user</p>
    <div v-else class="flex flex-col gap-5">
      <table class="rounded-xl shadow-md text-l text-left text-gray-500 bg-gray-50">
        <thead class="text-gray-700 uppercase border-gray-200 border-b">
        <tr>
          <th scope="col" class="px-6 py-3">Username</th>
          <th scope="col" class="px-6 py-3">Start Time</th>
          <th scope="col" class="px-6 py-3">End Time</th>
          <th scope="col" class="px-6 py-3">Status</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(workingtimes, i) in workingtimes" :key="i"
            class="">
          <td class="px-6 py-6">{{ current_user.username }}</td>
          <td class="px-6 py-6">{{ workingtimes.start_time }}</td>
          <td class="px-6 py-6">{{ workingtimes.end_time }}</td>
          <td class="px-6 py-6">{{ workingtimes.status }}</td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import {get_working_times_by_id} from "@/services/workingtimes.service";
import User from "@/App.vue";
import {users_service} from "@/services/users.service";

export default {
  name: "WorkingTimes",
  components: {User},
  data() {
    return {
      workingtimes: [],
      current_user: undefined
    };
  },
  methods: {
    getWorkingtimes: function () {
      users_service.get_user_by_id(this.$route.params.userID).then((response) => {
        this.current_user = response.data
      })

      get_working_times_by_id(this.$route.params.userID).then((result) => {
        this.workingtimes = result.data;
      });

    },
  },
  created() {
    this.getWorkingtimes();
  },
};
</script>