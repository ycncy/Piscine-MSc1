<template>
  <div class="container">
    <div class="row">
      <div class="py-4 col-md-12 flex flex-col justify-center items-center">
        <h1 class="text-center font-bold text-4xl">Working times List</h1>
        <table class="w-[80%] rounded text-sm text-left text-gray-500 dark:text-gray-400 m-4">
          <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th scope="col" class="px-6 py-3">User_id</th>
            <th scope="col" class="px-6 py-3">Start_time</th>
            <th scope="col" class="px-6 py-3">End_time</th>
            <th scope="col" class="px-6 py-3">Status</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(workingtimes, i) in workingtimes" :key="i" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
            <td class="px-6 py-4">{{ workingtimes.user_id }}</td>
            <td class="px-6 py-4">{{ workingtimes.start_time }}</td>
            <td class="px-6 py-4">{{ workingtimes.end_time }}</td>
            <td class="px-6 py-4">{{ workingtimes.status }}</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import {get_working_times_by_id} from "@/services/workingtimes.service";

export default {
  name: "WorkingTimes",
  data() {
    return {
      workingtimes: null,
    };
  },
  methods: {
    getWorkingtimes: function () {
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