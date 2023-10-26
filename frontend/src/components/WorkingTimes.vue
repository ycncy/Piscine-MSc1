

<template>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center">Working times List</h1>
                <table class="table table-striped table-dark" border="1">
                    <thead>
                        <tr>
                        <th scope="col">User_id</th>
                        <th scope="col">Start_time</th>
                        <th scope="col">End_time</th>
                        <th scope="col">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(workingtimes, i) in workingtimes_list" :key="i">
                        <td>{{ workingtimes.user_id }}</td>
                        <td>{{ workingtimes.start_time }}</td>
                        <td>{{ workingtimes.end_time }}</td>
                        <td>{{ workingtimes.status }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>

<script>
import { get_working_times_by_id, get_all_working_times } from "@/services/workingtimes.service";

  export default {
    name: "WorkingTimes",
  data() {
    return {
      workingtimes_list: null,
    };
  },
  methods: {
    getWorkingtimes: function () {
        get_all_working_times().then((result) => {
        console.log( result.data );
        this.workingtimes_list = result.data;
      });
    
    },
  },
  created() {
    this.getWorkingtimes();
  },
};
</script>