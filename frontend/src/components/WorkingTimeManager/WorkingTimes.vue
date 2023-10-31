<template>
  <div class="p-4 gap-3 col-md-12 flex flex-col">
    <p class="text-center align-middle text-4xl" v-if="this.working_times.length === 0">No working times found for this user</p>
    <div v-else class="flex flex-col gap-5">
      <table class="rounded-2xl shadow-md text-l text-left text-gray-500 bg-[#232323]">
        <thead class="text-gray-500 uppercase border-gray-200 border-b">
        <tr>
          <th scope="col" class="px-6 py-3 rounded-2xl">Username</th>
          <th scope="col" class="px-6 py-3 rounded-2xl">Start Time</th>
          <th scope="col" class="px-6 py-3 rounded-2xl">End Time</th>
          <th scope="col" class="px-6 py-3 rounded-2xl">Status</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(working_time, i) in this.working_times" :key="i">
          <td class="px-6 py-6 rounded-2xl">{{ this.current_user.username }}</td>
          <td class="px-6 py-6 rounded-2xl">{{ working_time.start_time }}</td>
          <td class="px-6 py-6 rounded-2xl">{{ working_time.end_time }}</td>
          <td class="px-6 py-6 rounded-2xl">{{ working_time.status }}</td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import User from "@/App.vue";
import {list} from "postcss";

export default {
  name: "WorkingTimes",
  components: {User},
  props: {
    current_user: Object,
    working_times: list
  }
};
</script>